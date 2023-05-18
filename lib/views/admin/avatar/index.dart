import 'package:flutter/material.dart';
import 'package:syberwaifu/components/buttons/custom_back_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/views/admin/avatar/components/avatar_table.dart';

class AvatarIndex extends StatefulWidget {
  const AvatarIndex({super.key});

  @override
  State<AvatarIndex> createState() => _AvatarIndexState();
}

class _AvatarIndexState extends State<AvatarIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        S.of(context).pageTitleAvatarManager,
        floatingLeadings: const [CustomBackButton()],
      ),
      body: const AvatarTable(),
    );
  }
}
