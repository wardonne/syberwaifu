import 'package:flutter/material.dart';

class ThemeConstants {
  static const bool defaultDarkModelSwitch = false;
  static const String darkModeEnable = '1';
  static const String darkModeDisable = '0';

  static const MaterialColor defaultColor = Colors.pink;
  static const String defaultColorIndex = 'pink';
  static const Map<String, MaterialColor> materialColors = {
    'amber': Colors.amber,
    'blue': Colors.blue,
    'blueGrey': Colors.blueGrey,
    'brown': Colors.brown,
    'cyan': Colors.cyan,
    'deepOrange': Colors.deepOrange,
    'deepPurple': Colors.deepPurple,
    'green': Colors.green,
    'indigo': Colors.indigo,
    'lightBlue': Colors.lightBlue,
    'lightGreen': Colors.lightGreen,
    'lime': Colors.lime,
    'orange': Colors.orange,
    'pink': Colors.pink,
    'purple': Colors.purple,
    'red': Colors.red,
    'teal': Colors.teal,
    'yellow': Colors.yellow,
  };

  static const String presetThemeColorEnabled = '1';
  static const String presetThemeColorDisabled = '0';
}
