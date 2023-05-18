import 'package:flutter/material.dart';
import 'package:syberwaifu/components/titled_card.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/views/admin/dashboard/components/cards/avatar_count_card.dart';

class ResourceManagerBoard extends StatelessWidget {
  const ResourceManagerBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      labelText: S.of(context).dashboardResourceBoard,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: const [
          AvatarCountCard(),
        ],
      ),
    );
  }
}
