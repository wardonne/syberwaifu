import 'package:flutter/material.dart';

Color forecolorFromColor(Color color) {
  return color.computeLuminance() < 0.5 ? Colors.white : Colors.black87;
}
