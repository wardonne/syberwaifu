import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syberwaifu/components/buttons/context_menu_button.dart';
import 'package:syberwaifu/components/dialogs/confirm_dialog.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/functions/show_message.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/view_models/chat/chat_messages_vm.dart';

class MessageItemPopupMenu extends StatefulWidget {
  final ChatMessageModel message;
  final ChatMessagesVM chatMessagesVM;
  const MessageItemPopupMenu({
    super.key,
    required this.message,
    required this.chatMessagesVM,
  });

  @override
  State<MessageItemPopupMenu> createState() => _MessageItemPopupMenuState();
}

class _MessageItemPopupMenuState extends State<MessageItemPopupMenu> {
  _copy() {
    Clipboard.setData(ClipboardData(text: widget.message.content ?? '')).then(
      (value) {
        if (context.mounted) {
          back(context);
          showMessage(context, S.of(context).messageCopied);
        }
      },
    );
  }

  _multiSelect() {
    back(context);
    widget.chatMessagesVM.multiSelectMode = true;
  }

  _quote([bool withContext = false]) {
    back(context);
    widget.chatMessagesVM.quote(widget.message, withContext);
  }

  _quoteWithContext() {
    _quote(true);
  }

  _delete() async {
    back(context);
    await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: S.of(context).btnDelete,
        content: S.of(context).confirmDeleteMessage,
        onConfirmed: () async {
          await widget.chatMessagesVM.deleteMessage([widget.message]);
          if (context.mounted) {
            Navigator.of(context).pop();
            showMessage(context, S.of(context).messageDeleteSuccess);
          }
        },
      ),
    );
  }

  _appendQuote() async {
    back(context);
    widget.chatMessagesVM.appendQuote(widget.message);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      children: [
        ContextMenuButton(
          icon: const Icon(Icons.copy),
          label: Text(S.of(context).btnCopy),
          onPressed: _copy,
        ),
        ContextMenuButton(
          icon: const Icon(Icons.playlist_add_check),
          label: Text(S.of(context).btnMultipleChoice),
          onPressed: _multiSelect,
        ),
        ContextMenuButton(
          icon: const Icon(Icons.format_quote),
          label: Text(S.of(context).btnQuote),
          onPressed: _quote,
        ),
        ContextMenuButton(
          icon: const Icon(Icons.request_quote),
          label: Text(S.of(context).btnQuoteWithContext),
          onPressed: _quoteWithContext,
        ),
        if (widget.chatMessagesVM.quoteMessages.isNotEmpty)
          ContextMenuButton(
            icon: const Icon(Icons.arrow_forward),
            label: Text(S.of(context).btnAppendQuote),
            onPressed: _appendQuote,
          ),
        ContextMenuButton(
          icon: const Icon(Icons.delete),
          label: Text(S.of(context).btnDelete),
          onPressed: _delete,
        ),
      ],
    );
  }
}
