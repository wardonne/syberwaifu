import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/view_models/chat/chat_list_vm.dart';
import 'package:syberwaifu/views/chat/components/chat_item.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListVM>(
      builder: (context, chatListVM, child) {
        final chats = chatListVM.chats;
        return Container(
          width: ApplicationConstants.chatListWidth,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.black26),
            ),
          ),
          child: ListView(children: [
            ...chats.map((chat) {
              final selected = chat.uuid == chatListVM.activeChat.uuid;
              return ChatItem(chat, selected: selected);
            }).toList(),
          ]),
        );
      },
    );
  }
}
