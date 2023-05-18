import 'package:flutter/material.dart';
import 'package:syberwaifu/services/openai_token_service.dart';

class OpenAITokenCountVM extends ChangeNotifier {
  final _service = OpenAITokenService();

  bool _loading = true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  int count = 0;

  OpenAITokenCountVM() {
    _service.count().then((value) {
      count = value;
      loading = false;
    });
  }
}
