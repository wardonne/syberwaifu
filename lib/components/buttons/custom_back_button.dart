import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (Navigator.of(context).canPop()) {
          back(context);
        } else {
          replace(context, RouterSettings.dashboard);
        }
      },
      icon: Icon(Icons.arrow_back,
          color: Provider.of<ThemeVM>(context).forecolor),
      splashRadius: 20.0,
      tooltip: S.of(context).btnBack,
    );
  }
}
