import 'package:flutter/material.dart';
import 'package:syberwaifu/generated/l10n.dart';

class ErrorDialog extends StatelessWidget {
  final String? title;
  final Object error;
  final StackTrace? stackTrace;

  const ErrorDialog({
    super.key,
    this.title,
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title ?? S.of(context).dialogTitleError),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$error',
                      textScaleFactor: 1.1,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              if (stackTrace != null) Text('$stackTrace'),
            ],
          ),
        ));
  }
}
