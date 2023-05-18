import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/count_card.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/dashboard/openai_token_count_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class OpenAITokenCountCard extends StatelessWidget {
  const OpenAITokenCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OpenAITokenCountVM(),
      child: Consumer2<OpenAITokenCountVM, ThemeVM>(
        builder: (context, vm, theme, child) {
          return CountCard(
            loading: vm.loading,
            icon: Icon(
              Icons.token,
              size: 70,
              color: theme.darkMode ? null : theme.forecolor,
            ),
            title: S.of(context).dashboardOpenAITokenCount,
            content: '${vm.count}',
            tooltip: S.of(context).dashboardOpenAITokenCountTooltip,
            onTap: () {
              replace(context, RouterSettings.openAITokenIndex);
            },
          );
        },
      ),
    );
  }
}
