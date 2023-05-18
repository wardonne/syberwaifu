import 'package:flutter/foundation.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/constants/chat_message.dart';
import 'package:syberwaifu/constants/openai_token.dart';
import 'package:syberwaifu/constants/settings.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/services/chat/chat_message_service.dart';
import 'package:syberwaifu/services/chat/chat_service.dart';
import 'package:syberwaifu/services/openai_token_service.dart';
import 'package:syberwaifu/services/preset/preset_service.dart';
import 'package:syberwaifu/services/settings/settings_service.dart';

class InitSettingsVM extends ChangeNotifier {
  final _openAITokenService = OpenAITokenService();
  final _chatService = ChatService();
  final _chatMessageService = ChatMessageService();
  final _presetService = PresetService();
  final _settingsService = SettingsService();

  bool _loading = false;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  InitSettingsVM()
      : _openAITokenModel = OpenAITokenModel(
          name: '默认秘钥',
          token: '',
          status: OpenAITokenConstants.enable,
        );

  final OpenAITokenModel _openAITokenModel;

  String get name => _openAITokenModel.name!;

  set token(String value) => _openAITokenModel.token = value;

  String get token => _openAITokenModel.token!;

  save() async {
    loading = true;
    final preset = await _presetService.defaultPreset();
    final presetMessages = await preset.messages;
    await Model.transaction((txn) async {
      _openAITokenService.beginTransaction(txn);
      final openAIToken = await _openAITokenService.create(_openAITokenModel);
      _openAITokenService.endTransaction();

      _chatService.beginTransaction(txn);
      final chat = await _chatService.create(
        ChatModel(
          openAITokenId: openAIToken.uuid,
          presetId: preset.uuid,
          name: preset.name,
        ),
      );
      _chatService.endTransaction();

      _chatMessageService.beginTransaction(txn);
      for (var presetMessage in presetMessages) {
        if (presetMessage.role == ChatMessageConstants.system) {
          continue;
        }
        await _chatMessageService.create(
          chatId: chat.uuid!,
          role: presetMessage.role!,
          content: presetMessage.content!,
        );
      }
      _chatMessageService.endTransaction();

      _settingsService.beginTransaction(txn);
      await _settingsService.save(
        SettingsConstants.applicationInited,
        ApplicationConstants.appInited,
      );
      _settingsService.endTransaction();
    });
    loading = false;
  }
}
