import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/count_card.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/dashboard/preset_count_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class PresetCountCard extends StatelessWidget {
  const PresetCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PresetCountVM(),
      child: Consumer2<PresetCountVM, ThemeVM>(
        builder: (context, vm, theme, child) {
          return CountCard(
            loading: vm.loading,
            icon: Icon(
              Icons.supervisor_account,
              size: 70,
              color: theme.darkMode ? null : theme.forecolor,
            ),
            title: S.of(context).dashboardPresetCount,
            content: '${vm.count}',
            tooltip: S.of(context).dashboardPresetCountTooltip,
            onTap: () {
              replace(context, RouterSettings.presetIndex);
            },
          );
        },
      ),
    );
  }
}
