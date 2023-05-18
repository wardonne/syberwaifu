import 'package:flutter/material.dart';
import 'package:syberwaifu/enums/divider_direction.dart';

class CustomDivider extends StatelessWidget {
  final DividerDirection direction;
  final double? size;
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const CustomDivider({
    super.key,
    this.direction = DividerDirection.horizontal,
    this.size = 10.0,
    this.color = Colors.transparent,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == DividerDirection.horizontal) {
      return Divider(
        height: size,
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      );
    } else {
      return VerticalDivider(
        width: size,
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      );
    }
  }
}
