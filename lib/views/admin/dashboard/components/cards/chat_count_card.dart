import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/count_card.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/dashboard/chat_count_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class ChatCountCard extends StatelessWidget {
  const ChatCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatCountVM(),
      child: Consumer2<ChatCountVM, ThemeVM>(
        builder: (context, vm, theme, child) {
          return CountCard(
            loading: vm.loading,
            icon: Icon(
              Icons.chat,
              size: 70,
              color: theme.darkMode ? null : theme.forecolor,
            ),
            title: S.of(context).dashboardChatCount,
            content: '${vm.count}',
            tooltip: S.of(context).dashboardChatCountTooltip,
            onTap: () {
              replace(context, RouterSettings.chatIndex);
            },
          );
        },
      ),
    );
  }
}
