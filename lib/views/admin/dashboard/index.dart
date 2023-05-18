import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/views/admin/dashboard/components/proxy_board.dart';
import 'package:syberwaifu/views/admin/dashboard/components/resource_manager_board.dart';
import 'package:syberwaifu/views/admin/dashboard/components/theme_board.dart';
import 'package:syberwaifu/components/buttons/back_to_chat_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/admin/dashboard/chat_count_vm.dart';
import 'package:syberwaifu/view_models/admin/dashboard/openai_token_count_vm.dart';
import 'package:syberwaifu/view_models/admin/dashboard/preset_count_vm.dart';
import 'components/data_stat_board.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(S.of(context).btnSettings, floatingLeadings: [
        Container(
            padding: const EdgeInsets.only(left: 10),
            height: 60,
            child: const BackToChatButton()),
      ]),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OpenAITokenCountVM()),
          ChangeNotifierProvider(create: (context) => PresetCountVM()),
          ChangeNotifierProvider(create: (context) => ChatCountVM()),
        ],
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: const [
                DataStatBoard(),
                ResourceManagerBoard(),
                ThemeBoard(),
                ProxyBoard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
