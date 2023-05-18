import 'package:flutter/material.dart';

class MessageTip extends StatelessWidget {
  final Widget child;
  const MessageTip({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(
        child: child,
      ),
    );
  }
}
