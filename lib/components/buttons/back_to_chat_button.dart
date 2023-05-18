import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class BackToChatButton extends StatelessWidget {
  const BackToChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        replace(context, RouterSettings.chat);
      },
      icon: Icon(
        Icons.chat,
        color: Provider.of<ThemeVM>(context).forecolor,
      ),
      splashRadius: 20.0,
      tooltip: S.of(context).btnBack2Chat,
    );
  }
}
