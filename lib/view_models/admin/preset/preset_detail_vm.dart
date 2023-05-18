import 'package:flutter/foundation.dart';
import 'package:syberwaifu/constants/chat_message.dart';
import 'package:syberwaifu/constants/preset.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/preset/preset_message_model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/services/preset/preset_message_service.dart';
import 'package:syberwaifu/services/preset/preset_service.dart';

class PresetDetailVM extends ChangeNotifier {
  final _presetService = PresetService();
  final _presetMessageService = PresetMessageService();

  PresetDetailVM()
      : _preset = PresetModel(
          name: '',
          nickname: '',
          isDefault: PresetConstants.notDefault,
        ),
        _editable = true {
    _messages.add(PresetMessageModel(
      presetId: _preset.uuid,
      role: ChatMessageConstants.system,
      content: "",
    ));
  }

  PresetDetailVM.detail(PresetModel model, this._editable) : _preset = model {
    loadingMessages = true;
    model.messages.then((value) {
      _messages = value;
      loadingMessages = false;
    });
  }

  final PresetModel _preset;

  PresetModel get preset => _preset;

  String get presetId => _preset.uuid!;

  set name(String value) {
    _preset.name = value;
    notifyListeners();
  }

  String get name => _preset.name!;

  set nickname(String value) {
    _preset.nickname = value;
    notifyListeners();
  }

  String get nickname => _preset.nickname!;

  set isDefault(int value) {
    _preset.isDefault = value;
    notifyListeners();
  }

  int get isDefault => _preset.isDefault!;

  DateTime? get createdAt => _preset.createdAt;

  DateTime? get updatedAt => _preset.updatedAt;

  List<PresetMessageModel> _messages = [];

  set messages(List<PresetMessageModel> value) {
    _messages = value;
    notifyListeners();
  }

  List<PresetMessageModel> get messages => _messages;

  bool _editable = false;

  set editable(bool value) {
    _editable = value;
    notifyListeners();
  }

  bool get editable => _editable;

  bool _loadingMessages = false;

  set loadingMessages(bool value) {
    _loadingMessages = value;
    notifyListeners();
  }

  bool get loadingMessages => _loadingMessages;

  bool _saving = false;

  set saving(bool value) {
    _saving = value;
    notifyListeners();
  }

  bool get saving => _saving;

  addMessage(PresetMessageModel message) {
    _messages.add(message);
    notifyListeners();
  }

  updateMessage(PresetMessageModel message) {
    final index =
        _messages.indexWhere((element) => element.uuid == message.uuid);
    _messages[index] = message;
  }

  removeMessage(PresetMessageModel message) {
    _messages.removeWhere((element) => element.uuid == message.uuid);
    notifyListeners();
  }

  save() async {
    saving = true;
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 5));
    }
    await Model.transaction((txn) async {
      _presetService.beginTransaction(txn);
      if (_preset.isNew) {
        await _presetService.create(_preset);
      } else {
        await _presetService.update(_preset);
      }
      _presetService.endTransaction();

      _presetMessageService.beginTransaction(txn);
      await _presetMessageService.deleteByPresetId(presetId);
      for (final message in _messages) {
        await _presetMessageService.create(message);
      }
      _presetMessageService.endTransaction();
    });
    saving = false;
  }
}
