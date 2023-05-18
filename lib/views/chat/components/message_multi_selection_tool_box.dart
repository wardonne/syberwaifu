import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_icon_button.dart';
import 'package:syberwaifu/components/dialogs/confirm_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/chat/chat_messages_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class MessageMultiSelectionToolBox extends StatelessWidget {
  const MessageMultiSelectionToolBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatMessagesVM, ThemeVM>(
      builder: (context, vm, theme, child) {
        return Container(
          height: 180,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black26)),
          ),
          child: Column(
            children: [
              const Divider(height: 10, color: Colors.transparent),
              Center(
                child: Text(
                  '${S.of(context).selectedMessageCount}:${vm.selectedMessages.length}/${vm.maxSelect}',
                  style: TextStyle(
                    color: theme.forecolor,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomIconButton(
                          icon: Icons.format_quote,
                          buttonHeight: 70,
                          buttonWidth: 70,
                          borderRadius: BorderRadius.circular(35.0),
                          color: Colors.black12,
                          hoverColor: Theme.of(context).colorScheme.background,
                          hoverIconColor: theme.forecolor,
                          tooltip: S.of(context).btnQuote,
                          onPressed: () {
                            vm.selectedMessages.sort(
                                (a, b) => a.createdAt!.compareTo(b.createdAt!));
                            vm.quoteMessages = vm.selectedMessages;
                          },
                        ),
                        CustomIconButton(
                          icon: Icons.delete,
                          buttonHeight: 70,
                          buttonWidth: 70,
                          borderRadius: BorderRadius.circular(35.0),
                          color: Colors.black12,
                          hoverColor: Theme.of(context).colorScheme.background,
                          hoverIconColor: theme.forecolor,
                          tooltip: S.of(context).btnDelete,
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return ConfirmDialog(
                                  title: S.of(context).btnDelete,
                                  content: S.of(context).confirmDeleteMessage,
                                  onConfirmed: () async {
                                    Navigator.of(context).pop();
                                    await vm.deleteMessage(vm.selectedMessages);
                                  },
                                );
                              },
                            );
                            vm.multiSelectMode = false;
                          },
                        ),
                        CustomIconButton(
                          icon: Icons.close,
                          buttonHeight: 70,
                          buttonWidth: 70,
                          borderRadius: BorderRadius.circular(35.0),
                          color: Colors.black12,
                          hoverColor: Theme.of(context).colorScheme.background,
                          hoverIconColor: theme.forecolor,
                          tooltip: S.of(context).btnQuit,
                          onPressed: () {
                            vm.multiSelectMode = false;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
