import 'package:flutter/material.dart';

showMessage(BuildContext context, String content) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(SnackBar(
    showCloseIcon: true,
    closeIconColor: Colors.black54,
    content: Text(content),
  ));
}
