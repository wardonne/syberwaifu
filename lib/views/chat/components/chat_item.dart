import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/chat_avatar.dart';
import 'package:syberwaifu/constants/assets.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/view_models/chat/chat_list_vm.dart';
import 'package:syberwaifu/views/chat/components/chat_item_context_menu.dart';

class ChatItem extends StatefulWidget {
  final ChatModel chat;
  final bool selected;

  const ChatItem(this.chat, {required this.selected, super.key});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return ContextMenuArea(
      width: 200,
      builder: (buildContext) {
        return [
          ChatItemContextMenu(
            chat: widget.chat,
            chatListVM: Provider.of<ChatListVM>(context),
          ),
        ];
      },
      child: ListTile(
        selected: widget.selected,
        selectedTileColor: Colors.black12,
        selectedColor: Theme.of(context).colorScheme.primary,
        leading: FutureBuilder<String>(future: () async {
          final avatar = await widget.chat.avatar;
          return avatar?.uri ?? AssetsConstants.defaultAIAvatar;
        }(), builder: (context, snapshot) {
          return ChatAvatar.small(
            avatar: snapshot.data ?? AssetsConstants.defaultAIAvatar,
          );
        }),
        title: Text(widget.chat.name!),
        trailing: Text(widget.chat.chatedAt),
        subtitle: FutureBuilder(
          future: widget.chat.latestMessage,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final latestMessage = snapshot.data;
              return Text(
                latestMessage?.content ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            } else {
              return const Text('');
            }
          },
        ),
        onTap: () {
          Provider.of<ChatListVM>(context, listen: false).activeChat =
              widget.chat;
        },
      ),
    );
  }
}
