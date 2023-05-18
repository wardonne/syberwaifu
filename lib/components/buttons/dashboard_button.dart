import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).popAndPushNamed(RouterSettings.dashboard);
      },
      icon: Icon(
        Icons.developer_board,
        color: Provider.of<ThemeVM>(context).forecolor,
      ),
      splashRadius: 20.0,
      tooltip: S.of(context).btnDashboard,
    );
  }
}
