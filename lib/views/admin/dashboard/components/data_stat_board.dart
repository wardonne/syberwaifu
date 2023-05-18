import 'package:flutter/material.dart';

import 'package:syberwaifu/components/titled_card.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/views/admin/dashboard/components/cards/chat_count_card.dart';
import 'package:syberwaifu/views/admin/dashboard/components/cards/openai_token_count_card.dart';
import 'package:syberwaifu/views/admin/dashboard/components/cards/preset_count_card.dart';

class DataStatBoard extends StatelessWidget {
  const DataStatBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      labelText: S.of(context).dashboardDataStat,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: const [
          OpenAITokenCountCard(),
          PresetCountCard(),
          ChatCountCard(),
        ],
      ),
    );
  }
}
