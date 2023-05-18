import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/constants/assets.dart';
import 'package:syberwaifu/constants/chat_message.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/image.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/services/avatar_service.dart';
import 'package:syberwaifu/services/chat/chat_message_service.dart';
import 'package:syberwaifu/services/chat/chat_service.dart';
import 'package:syberwaifu/services/preset/preset_service.dart';
import 'package:uuid/uuid.dart';

class ChatDetailVM extends ChangeNotifier {
  final _chatService = ChatService();
  final _chatMessageService = ChatMessageService();
  final _presetService = PresetService();
  final _avatarService = AvatarService();

  ChatDetailVM()
      : _chat = ChatModel(
          openAITokenId: '',
          presetId: '',
          name: '',
        ),
        _editable = true,
        _avatar = null,
        isCreate = true;

  ChatDetailVM.detail(this._chat, this._editable) {
    isCreate = false;
    _loading = true;
    _chat.avatar.then((value) {
      _avatar = value;
      _loading = false;
      notifyListeners();
    });
  }

  bool _loading = false;

  bool get loading => _loading;

  late final bool isCreate;

  late final AvatarModel? _avatar;

  AvatarModel? _tempAvatar;

  set avatar(String value) {
    _tempAvatar = AvatarModel(uri: value);
    notifyListeners();
  }

  String get avatar => empty(_tempAvatar)
      ? (_avatar?.uri ?? AssetsConstants.defaultAIAvatar)
      : _tempAvatar!.uri!;

  late final ChatModel _chat;

  ChatModel get chat => _chat;

  set name(String value) => _chat.name = value;

  String get name => _chat.name!;

  set presetId(String value) => _chat.presetId = value;

  String get presetId => _chat.presetId!;

  set openAITokenId(String value) => _chat.openAITokenId = value;

  String get openAITokenId => _chat.openAITokenId!;

  DateTime? get lastedChatedAt => _chat.lastChatedAt;

  DateTime? get createdAt => _chat.createdAt;

  DateTime? get updatedAt => _chat.updatedAt;

  bool _editable = false;

  set editable(bool value) {
    _editable = value;
    notifyListeners();
  }

  bool get editable => _editable;

  bool _saving = false;

  bool get saving => _saving;

  set saving(bool value) {
    _saving = value;
    notifyListeners();
  }

  Future<void> save() async {
    saving = true;
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 5));
    }

    final preset = await _presetService.detail(_chat.presetId!);
    final presetMessages = await preset.messages;

    await Model.transaction((txn) async {
      if (!empty(_tempAvatar)) {
        if (_tempAvatar!.isNew) {
          debugPrint('createAvatar');
          final tempAvatar = File(getUri(_tempAvatar!.uri!));
          final ext = extension(_tempAvatar!.uri!);
          final documentDirpath = await getApplicationDocumentsDirectory();
          final renamedAvatar = await tempAvatar.rename(joinAll([
            documentDirpath.path,
            ApplicationConstants.avatarDirpath,
            '${const Uuid().v4()}$ext',
          ]));
          _tempAvatar!.uri = 'file://${renamedAvatar.path}';
          _avatarService.beginTransaction(txn);
          _avatarService.create(_tempAvatar!);
          _avatarService.endTransaction();
        }
        _chat.avatarId = _tempAvatar!.uuid;
      }
      _chatService.beginTransaction(txn);
      if (_chat.isNew) {
        _chatService.create(_chat);

        _chatMessageService.beginTransaction(txn);
        for (var message in presetMessages.reversed) {
          if (message.role == ChatMessageConstants.system) {
            continue;
          }
          await _chatMessageService.create(
            chatId: _chat.uuid!,
            role: message.role!,
            content: message.content!,
          );
        }
        _chatMessageService.endTransaction();
      } else {
        _chatService.update(_chat);
      }
      _chatService.endTransaction();
    });
  }

  importAvatar(AvatarModel model) {
    _tempAvatar = model;
    notifyListeners();
  }
}
