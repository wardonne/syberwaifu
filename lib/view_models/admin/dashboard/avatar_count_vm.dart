import 'package:flutter/material.dart';
import 'package:syberwaifu/services/avatar_service.dart';

class AvatarCountVM extends ChangeNotifier {
  final _service = AvatarService();

  bool _loading = true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  int count = 0;

  AvatarCountVM() {
    _service.count().then((value) {
      count = value;
      loading = false;
    });
  }
}
