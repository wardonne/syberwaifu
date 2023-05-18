import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class NewChatButton extends StatelessWidget {
  const NewChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeVM>(context);
    final icon = Icon(
      Icons.add_circle,
      color: themeVM.forecolor,
    );
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: IconButton(
        splashRadius: 20.0,
        tooltip: S.of(context).btnCreateNewChat,
        onPressed: () async {
          Navigator.of(context).pushNamed(RouterSettings.chatCreate);
        },
        icon: icon,
      ),
    );
  }
}
