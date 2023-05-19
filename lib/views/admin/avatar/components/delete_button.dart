import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_icon_button.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/functions/open_dialog.dart';
import 'package:syberwaifu/functions/show_message.dart';
import 'package:syberwaifu/functions/try.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/view_models/admin/avatar/avatar_index_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class DeleteButton extends StatelessWidget {
  final AvatarModel avatar;
  const DeleteButton({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeVM, AvatarIndexVM>(
      builder: (context, theme, vm, child) {
        return CustomIconButton(
          icon: Icons.delete,
          iconSize: 20,
          buttonHeight: 24,
          buttonWidth: 24,
          borderRadius: BorderRadius.circular(12),
          hoverColor: Theme.of(context).colorScheme.primary,
          hoverIconColor: theme.forecolor,
          tooltip: S.of(context).btnDelete,
          onPressed: () async {
            await openConfirmDialog(
              context,
              message: S.of(context).confirmDeleteAvatar,
              onConfirmed: () async {
                back(context);
                await tryRun(
                  () async => await vm.delete(avatar),
                  onError: (error) async {
                    debugPrint('$error');
                  },
                  onSuccess: (result) async {
                    showMessage(context, '删除成功');
                    vm.refresh();
                  },
                );
              },
            );
            vm.refresh();
          },
        );
      },
    );
  }
}
