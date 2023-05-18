import 'package:flutter/material.dart';

class SwitchCell extends StatelessWidget {
  final bool value;
  final Function(bool value)? onChanged;
  const SwitchCell({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Switch(
          value: value,
          onChanged: onChanged ?? (value) {},
        ),
      ),
    );
  }
}
