import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final void Function()? onPressed;
  final double? height;
  final double? widget;
  const CustomElevatedButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
    this.height,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget,
      height: height ?? 40,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: label,
      ),
    );
  }
}
