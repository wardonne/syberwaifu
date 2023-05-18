import 'package:flutter/material.dart';

class ColorLensCell extends StatelessWidget {
  final Color value;
  const ColorLensCell({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: CircleAvatar(
          backgroundColor: value,
          radius: 15,
        ),
      ),
    );
  }
}
