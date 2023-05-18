import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/view_models/chat/chat_messages_vm.dart';
import 'package:syberwaifu/view_models/chat/chat_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/chat/components/message_display_box.dart';
import 'package:syberwaifu/views/chat/components/message_input_box.dart';
import 'package:syberwaifu/views/chat/components/message_multi_selection_tool_box.dart';
import 'package:syberwaifu/views/chat/components/message_quote_box.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChatMainState();
  }
}

class ChatMainState extends State<ChatMain> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<ChatVM, ChatMessagesVM>(
      create: (context) =>
          ChatMessagesVM(Provider.of<ChatVM>(context, listen: false).chat),
      update: (context, value, previous) {
        if (value.chatId != previous!.chatId) {
          return ChatMessagesVM(value.chat);
        }
        return previous;
      },
      child: Consumer3<ChatVM, ChatMessagesVM, ThemeVM>(
        builder: (context, chatVM, chatMessagesVM, themeVM, child) {
          final loading = Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                size: 30.0, color: Theme.of(context).primaryColor),
          );
          if (Provider.of<ChatMessagesVM>(context).loading) {
            return loading;
          }
          final scrollController = ScrollController();
          scrollController.addListener(() async {
            if (chatMessagesVM.loadingMore) {
              return;
            }
            if (!chatMessagesVM.hasMore) {
              return;
            }
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              chatMessagesVM.loadingMore = true;
              await chatMessagesVM.loadMessage();
              chatMessagesVM.loadingMore = false;
            }
          });

          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MessageDisplayBox(
                  scrollController: scrollController,
                ),
              ),
              if (chatMessagesVM.quoteMessages.isNotEmpty)
                const MessageQuoteBox(),
              if (chatMessagesVM.multiSelectMode)
                const MessageMultiSelectionToolBox()
              else
                MessageInputBox(
                  scrollController: scrollController,
                ),
            ],
          );
        },
      ),
    );
  }
}
