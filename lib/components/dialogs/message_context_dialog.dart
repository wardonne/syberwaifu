import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/dialogs/content_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/chat/components/message_item.dart';

class MessageContextDialog extends StatelessWidget {
  final List<ChatMessageModel> quoteMessages;

  const MessageContextDialog({
    super.key,
    required this.quoteMessages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeVM>(context);
    const userAvatar = CircleAvatar(
      backgroundColor: Colors.blueAccent,
      child: Icon(Icons.face, color: Colors.white),
    );
    final aiAvatar = CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.tag_faces, color: Colors.white));
    return ContentDialog(
      title: Text(S.of(context).dialogTitleQuote),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final quoteMessage = quoteMessages[index];
          return MessageItem(
            avatar: quoteMessage.isSendByUser() ? userAvatar : aiAvatar,
            contentText: quoteMessage.content!,
            textDirection: quoteMessage.isSendByUser()
                ? TextDirection.rtl
                : TextDirection.ltr,
            textStyle: TextStyle(
              color:
                  quoteMessage.isSendByUser() ? Colors.white : theme.forecolor,
            ),
            backgroundColor: quoteMessage.isSendByUser()
                ? Colors.blueAccent
                : Theme.of(context).colorScheme.background,
          );
        },
        itemCount: quoteMessages.length,
      ),
    );
  }
}
