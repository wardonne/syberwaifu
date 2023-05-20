import 'package:flutter/material.dart';
import 'package:syberwaifu/components/buttons/context_menu_button.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/functions/open_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/chat/chat_list_vm.dart';

class ChatItemContextMenu extends StatelessWidget {
  final ChatModel chat;
  final ChatListVM chatListVM;
  const ChatItemContextMenu({
    super.key,
    required this.chat,
    required this.chatListVM,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      children: [
        ContextMenuButton(
          icon: const Icon(Icons.search),
          label: Text(S.of(context).btnView),
          onPressed: () {
            replace(context, RouterSettings.chatDetail, arguments: chat);
          },
        ),
        ContextMenuButton(
          icon: const Icon(Icons.edit),
          label: Text(S.of(context).btnEdit),
          onPressed: () async {
            await replace(context, RouterSettings.chatUpdate, arguments: chat);
            chatListVM.reload();
          },
        ),
        if (chatListVM.chats.length > 1)
          ContextMenuButton(
            icon: const Icon(Icons.delete_forever),
            label: Text(S.of(context).btnDelete),
            onPressed: () async {
              await openConfirmDialog(
                context,
                message: S.of(context).confirmDeleteMessage,
                onConfirmed: () async {
                  await chatListVM.deleteChat(chat);
                  chatListVM.reload();
                  if (context.mounted) {
                    back(context);
                  }
                },
              );
              if (context.mounted) {
                back(context);
              }
            },
          ),
      ],
    );
  }
}
