import 'package:flutter/material.dart';
import 'package:syberwaifu/functions/navigator.dart';

class ContentDialog extends StatelessWidget {
  final Widget title;
  final Widget child;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? contentPadding;
  const ContentDialog({
    super.key,
    required this.title,
    required this.child,
    this.titlePadding,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      title: Row(
        children: [
          Expanded(child: title),
          IconButton(
            onPressed: () {
              back(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: size.width - 200,
        height: size.width * 0.6,
        child: child,
      ),
    );
  }
}
