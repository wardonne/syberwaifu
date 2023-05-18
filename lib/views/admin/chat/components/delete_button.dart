import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_icon_button.dart';
import 'package:syberwaifu/components/dialogs/confirm_dialog.dart';
import 'package:syberwaifu/functions/show_message.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_index_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class DeleteButton extends StatelessWidget {
  final ChatModel chat;

  const DeleteButton({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeVM>(builder: (context, theme, child) {
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
          showDialog(
            context: context,
            builder: (_) => ConfirmDialog(
              title: S.of(context).dialogTitleDeletePreset,
              content: S.of(context).confirmDeleteMessage,
              onConfirmed: () async {
                if (context.mounted) {
                  final vm = Provider.of<ChatIndexVM>(context, listen: false);
                  await vm.deleteChat(chat.uuid!);
                  if (context.mounted) {
                    showMessage(context, S.of(context).messageDeleteSuccess);
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          );
        },
      );
    });
  }
}
