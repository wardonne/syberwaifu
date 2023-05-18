import 'package:flutter/material.dart';
import 'package:syberwaifu/constants/settings.dart';
import 'package:syberwaifu/constants/theme.dart';
import 'package:syberwaifu/services/settings/settings_service.dart';

class ThemeVM extends ChangeNotifier {
  final settingsService = SettingsService();

  late Color _forecolor;

  set forecolor(Color value) => _forecolor = value;

  Color get forecolor => darkMode ? Colors.white : _forecolor;

  late MaterialColor _color;

  set color(MaterialColor value) {
    _color = value;
    final colorIndex = ThemeConstants.materialColors.entries
        .firstWhere((element) => element.value == value)
        .key;
    settingsService
        .save(SettingsConstants.themeColor, colorIndex)
        .then((value) {
      notifyListeners();
    });
  }

  MaterialColor get color => _color;

  late MaterialColor _chatColor;

  set chatColor(MaterialColor value) {
    _chatColor = value;
    notifyListeners();
  }

  MaterialColor get chatColor => _chatColor;

  late bool _darkMode;

  set darkMode(bool value) {
    _darkMode = value;
    settingsService.save(
      SettingsConstants.themeDarkMode,
      value ? ThemeConstants.darkModeEnable : ThemeConstants.darkModeDisable,
    );
    notifyListeners();
  }

  bool get darkMode => _darkMode;

  switchDarkMode() {
    darkMode = !darkMode;
  }

  ThemeVM(this._color, this._darkMode) : _chatColor = _color;
}
