import 'package:flutter/material.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/constants/settings.dart';
import 'package:syberwaifu/services/settings/settings_service.dart';

class AppInitVM extends ValueNotifier<bool> {
  final _settingsService = SettingsService();

  AppInitVM(super._value);

  setInited() async {
    await _settingsService.save(
        SettingsConstants.applicationInited, ApplicationConstants.appInited);
    value = true;
  }
}
