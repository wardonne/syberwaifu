import 'package:flutter/material.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:window_manager/window_manager.dart';

class MinimizeWindowButton extends StatefulWidget {
  const MinimizeWindowButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return MinimizeWindowButtonState();
  }
}

class MinimizeWindowButtonState extends State<MinimizeWindowButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: windowManager.minimize,
      icon: const Icon(
        Icons.minimize,
        color: Colors.white,
      ),
      splashRadius: 20.0,
      tooltip: S.of(context).btnMinimize,
    );
  }
}
