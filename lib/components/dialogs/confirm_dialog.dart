import 'package:flutter/material.dart';
import 'package:syberwaifu/generated/l10n.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function()? onConfirmed;
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: onConfirmed,
          icon: const Icon(
            Icons.send,
            size: 20.0,
          ),
          label: Text(S.of(context).btnConfirm),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.background,
            ),
          ),
          icon: const Icon(
            Icons.cancel,
            size: 20.0,
          ),
          label: Text(S.of(context).btnCancel),
        ),
      ],
    );
  }
}
