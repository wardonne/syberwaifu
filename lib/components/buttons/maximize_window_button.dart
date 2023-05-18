import 'package:flutter/material.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:window_manager/window_manager.dart';

class MaximizeWindowButton extends StatefulWidget {
  const MaximizeWindowButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return MaximizeWindowButtonState();
  }
}

class MaximizeWindowButtonState extends State<MaximizeWindowButton> {
  late bool _isMaximized = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: windowManager.isMaximized(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _isMaximized = snapshot.data ?? false;
            return IconButton(
              onPressed: () async {
                _isMaximized
                    ? await windowManager.unmaximize()
                    : await windowManager.maximize();
                setState(() {
                  _isMaximized = !_isMaximized;
                });
              },
              icon: Icon(
                _isMaximized ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white,
              ),
              splashRadius: 20.0,
              tooltip: _isMaximized
                  ? S.of(context).btnRestore
                  : S.of(context).btnMaximize,
            );
          } else {
            return Container();
          }
        });
  }
}
