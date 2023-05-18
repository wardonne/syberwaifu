import 'package:flutter/material.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';

class ChatVM extends ChangeNotifier {
  bool _loading = false;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  late ChatModel? _chat;

  set chat(ChatModel value) {
    loading = false;
    _chat = value;
    loading = true;
  }

  ChatModel get chat => _chat!;

  String get chatId => _chat!.uuid!;

  String get title => _chat!.name!;

  ChatVM(this._chat) {
    loading = true;
    chat.preset
        .then((value) => _preset = value)
        .then((value) => loading = false);
  }

  late PresetModel? _preset;

  PresetModel? get preset => _preset;
}
