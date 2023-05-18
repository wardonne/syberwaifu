import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/chat_avatar.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/constants/assets.dart';
import 'package:syberwaifu/functions/open_dialog.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/view_models/chat/chat_messages_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/chat/components/message_tip.dart';
import 'package:syberwaifu/views/chat/components/message_item_context_menu.dart';
import 'package:syberwaifu/views/chat/components/message_item.dart';

class MessageDisplayBox extends StatefulWidget {
  final ScrollController scrollController;
  const MessageDisplayBox({
    super.key,
    required this.scrollController,
  });

  @override
  State<StatefulWidget> createState() {
    return MessageDisplayBoxState();
  }
}

class MessageDisplayBoxState extends State<MessageDisplayBox> {
  late ThemeVM themeVM;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeVM, ChatMessagesVM>(
      builder: (context, theme, vm, child) {
        if (vm.loading) {
          return const Center(child: Loading());
        }
        const userAvatar = ChatAvatar.small(
          avatar: AssetsConstants.defaultUserAvatar,
        );
        final aiAvatar = ChatAvatar.small(avatar: vm.avatar);
        final List<Widget> items = [];
        ChatMessageModel? prevMessage;
        for (var message in vm.messages) {
          if (prevMessage != null &&
              message.hasPasedMinutes(15, prevMessage.createdAt)) {
            items.add(
              MessageTip(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: Text(
                    prevMessage.messageTime,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            );
          }

          final withContextMenu = !vm.multiSelectMode;
          final hasError = vm.errors.containsKey(message.uuid!);
          final hasQuote = vm.cachedQuoteMessages.containsKey(message.uuid!);
          items.add(
            MessageItem(
              avatar: message.isSendByUser() ? userAvatar : aiAvatar,
              contentText: message.content!,
              textDirection: message.isSendByUser()
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              textStyle: TextStyle(
                color: message.isSendByUser() ? Colors.white : theme.forecolor,
              ),
              backgroundColor: message.isSendByUser()
                  ? Colors.blueAccent
                  : Theme.of(context).colorScheme.background,
              withContextMenu: withContextMenu,
              contextMenu: MessageItemPopupMenu(
                message: message,
                chatMessagesVM: vm,
              ),
              selectable: vm.multiSelectMode,
              selected: vm.selectedMessages.contains(message),
              onSelectChanged: (value) {
                vm.selectMessage(message);
              },
              hasError: hasError,
              error: vm.errors[message.uuid!],
              onErrorIconPressed: () {
                openErrorMessageDialog(context, message, vm);
              },
              showQuoteIcon: hasQuote,
              quoteMessages: vm.cachedQuoteMessages[message.uuid!] ?? [],
            ),
          );
          prevMessage = message;
        }

        if (vm.loadingMore) {
          items.add(const MessageTip(child: Loading()));
          Future.delayed(
              const Duration(milliseconds: 16),
              () async => widget.scrollController
                  .jumpTo(widget.scrollController.position.maxScrollExtent));
        }
        if (vm.loadingResponse) {
          items.insert(
              0,
              MessageItem.loading(
                avatar: aiAvatar,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ));
        }
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              reverse: true,
              shrinkWrap: true,
              controller: widget.scrollController,
              padding: const EdgeInsets.all(10.0),
              children: items,
            ),
          ),
        );
      },
    );
  }
}
