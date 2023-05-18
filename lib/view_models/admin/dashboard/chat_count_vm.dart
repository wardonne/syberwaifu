import 'package:flutter/material.dart';
import 'package:syberwaifu/services/chat/chat_service.dart';

class ChatCountVM extends ChangeNotifier {
  final _service = ChatService();

  bool _loading = true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  int count = 0;

  ChatCountVM() {
    _service.count().then((value) {
      count = value;
      loading = false;
    });
  }
}
