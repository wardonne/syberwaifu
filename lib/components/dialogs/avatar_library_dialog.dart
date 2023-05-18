import 'package:flutter/material.dart';
import 'package:syberwaifu/components/dialogs/content_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/views/admin/avatar/components/avatar_table.dart';

class AvatarLibraryDialog extends StatelessWidget {
  const AvatarLibraryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(S.of(context).dashboardAvatarLibrary),
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
      child: const AvatarTable(
        isPopup: true,
      ),
    );
  }
}
