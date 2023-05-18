import 'package:flutter/foundation.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/services/preset/preset_service.dart';

class PresetListVM extends ChangeNotifier {
  final _presetService = PresetService();

  bool _loading = false;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  final List<PresetModel> _presets = [];

  List<PresetModel> get presets => _presets;

  PresetListVM() {
    _presetService.list().then((List<PresetModel> models) {
      _presets.addAll(models);
      loading = false;
    });
  }
}
