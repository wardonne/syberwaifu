import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/chat/chat_list_vm.dart';
import 'package:syberwaifu/view_models/chat/chat_messages_vm.dart';

class MessageInputBox extends StatefulWidget {
  final ScrollController scrollController;
  const MessageInputBox({
    super.key,
    required this.scrollController,
  });

  @override
  State<StatefulWidget> createState() {
    return MessageInputBoxState();
  }
}

class MessageInputBoxState extends State<MessageInputBox> {
  final messageInputController = TextEditingController();

  late final FocusNode focusNode;

  late ChatMessagesVM chatMessagesVM;

  @override
  initState() {
    focusNode = FocusNode(
      onKey: (node, event) {
        if (!event.isShiftPressed && event.logicalKey.keyLabel == 'Enter') {
          if (event is RawKeyDownEvent) {
            sendMessage();
          }
          return KeyEventResult.handled;
        } else {
          return KeyEventResult.ignored;
        }
      },
    );
    super.initState();
  }

  sendMessage() async {
    final content = messageInputController.text;
    if (content.trim().isEmpty) {
      return;
    }
    messageInputController.clear();

    final requestMessage = await chatMessagesVM.createMessage(content.trim());
    if (context.mounted) {
      Provider.of<ChatListVM>(context, listen: false)
          .refreshItemAndSort(chatMessagesVM.chat);
    }
    chatMessagesVM.loadingResponse = true;
    widget.scrollController.jumpTo(0.0);
    await chatMessagesVM.sendMessage(requestMessage);
    chatMessagesVM.loadingResponse = false;
    widget.scrollController.jumpTo(0.0);
    if (context.mounted) {
      Provider.of<ChatListVM>(context, listen: false)
          .refreshItemAndSort(chatMessagesVM.chat);
    }
  }

  @override
  Widget build(BuildContext context) {
    chatMessagesVM = Provider.of<ChatMessagesVM>(context, listen: false);
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _messageInputBox(),
          _messageButtonBox(),
        ],
      ),
    );
  }

  Widget _messageInputBox() {
    return Expanded(
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black26))),
        child: TextField(
          focusNode: focusNode,
          controller: messageInputController,
          autofocus: true,
          maxLength: 140,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          selectionHeightStyle: BoxHeightStyle.max,
          selectionWidthStyle: BoxWidthStyle.max,
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _messageButtonBox() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
            label: Text(S.of(context).btnSend),
          ),
        ],
      ),
    );
  }
}
