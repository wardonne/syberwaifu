import 'package:flutter/material.dart';

class NumberCell extends StatelessWidget {
  final num value;
  final bool? clickable;
  final void Function()? onPressed;
  const NumberCell({
    super.key,
    required this.value,
    this.clickable,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      value.toString(),
      overflow: TextOverflow.ellipsis,
    );
    if (clickable ?? false) {
      content = TextButton(onPressed: onPressed, child: content);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: content,
      ),
    );
  }
}
