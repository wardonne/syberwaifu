import 'package:flutter/material.dart';
import 'package:syberwaifu/services/preset/preset_service.dart';

class PresetCountVM extends ChangeNotifier {
  final _service = PresetService();

  bool _loading = true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  int count = 0;

  PresetCountVM() {
    _service.count().then((value) {
      count = value;
      loading = false;
    });
  }
}
