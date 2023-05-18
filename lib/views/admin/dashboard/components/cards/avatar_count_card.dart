import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/count_card.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/dashboard/avatar_count_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class AvatarCountCard extends StatelessWidget {
  const AvatarCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AvatarCountVM(),
      child: Consumer2<AvatarCountVM, ThemeVM>(
        builder: (context, vm, theme, child) {
          return CountCard(
            loading: vm.loading,
            icon: Icon(
              Icons.portrait,
              size: 70,
              color: theme.darkMode ? null : theme.forecolor,
            ),
            title: S.of(context).dashboardAvatarLibrary,
            content: '${vm.count}',
            tooltip: S.of(context).dashboardAvatarCountTooltip,
            onTap: () {
              replace(context, RouterSettings.avatarIndex);
            },
          );
        },
      ),
    );
  }
}
