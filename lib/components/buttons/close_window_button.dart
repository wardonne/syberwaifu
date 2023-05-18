import 'package:flutter/material.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:window_manager/window_manager.dart';

class CloseWindowButton extends StatefulWidget {
  const CloseWindowButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return CloseWindowButtonState();
  }
}

class CloseWindowButtonState extends State<CloseWindowButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      mouseCursor: SystemMouseCursors.click,
      tooltip: S.of(context).btnClose,
      onPressed: windowManager.close,
      icon: const Icon(
        Icons.close,
        color: Colors.white,
      ),
      splashRadius: 20.0,
      hoverColor: Theme.of(context).hoverColor,
    );
  }
}
