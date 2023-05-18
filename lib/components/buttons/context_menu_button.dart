import 'package:flutter/material.dart';

class ContextMenuButton extends StatelessWidget {
  final Icon icon;
  final Widget label;
  final Function()? onPressed;

  const ContextMenuButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: label,
      onTap: onPressed,
    );
  }
}
