import 'package:flutter/material.dart';
import 'package:syberwaifu/constants/chat_message.dart';
import 'package:syberwaifu/models/preset/preset_message_model.dart';

class PresetMessageCreateVM extends ChangeNotifier {
  PresetMessageCreateVM(String presetId)
      : _message = PresetMessageModel(
          presetId: presetId,
          role: ChatMessageConstants.assistant,
          content: '',
        );

  final PresetMessageModel _message;

  PresetMessageModel get message => _message;

  set role(String value) {
    _message.role = value;
    notifyListeners();
  }

  String get role => _message.role!;

  set content(String value) {
    _message.content = value;
    notifyListeners();
  }

  String get content => _message.content!;
}
