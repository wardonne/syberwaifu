import 'dart:ui';

import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_icon_button.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/dialogs/message_context_dialog.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/select_wrapper.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/enums/divider_direction.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class MessageItem extends StatelessWidget {
  final Widget? avatar;
  final String? contentText;
  final Widget? content;
  final TextDirection? textDirection;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool? selectable;
  final bool? selected;
  final void Function(bool? value)? onSelectChanged;
  final bool? hasError;
  final Object? error;
  final void Function()? onErrorIconPressed;
  final bool? withContextMenu;
  final Widget? contextMenu;
  final bool? showQuoteIcon;
  final List<ChatMessageModel>? quoteMessages;
  MessageItem({
    super.key,
    this.avatar,
    this.contentText,
    this.content,
    this.textDirection,
    this.backgroundColor,
    this.textStyle,
    this.selectable,
    this.selected,
    this.onSelectChanged,
    this.hasError,
    this.error,
    this.onErrorIconPressed,
    this.withContextMenu,
    this.contextMenu,
    this.showQuoteIcon,
    this.quoteMessages,
  })  : assert(
          !(empty<String>(contentText) && content == null),
          'message and content can\'t both be null',
        ),
        assert(
          !((hasError ?? false) && empty<Object>(error)),
          'error can\'t be null when hasError is true',
        ),
        assert(
          !((withContextMenu ?? false) && empty<Widget>(contextMenu)),
          'contextMenu can\'t be null when withContextMenu is true',
        ),
        assert(
          !((showQuoteIcon ?? false) && empty<List>(quoteMessages)),
          'quoteMessages can\'t be empty when showQuoteIcon is true',
        );

  MessageItem.message({
    Key? key,
    required Widget avatar,
    required String contentText,
    Color? backgroundColor,
    TextStyle? textStyle,
    TextDirection? textDirection,
  }) : this(
          key: key,
          avatar: avatar,
          contentText: contentText,
          textDirection: textDirection,
          backgroundColor: backgroundColor,
          textStyle: textStyle,
        );

  MessageItem.loading({
    Key? key,
    required Widget avatar,
    Color? backgroundColor,
  }) : this(
          key: key,
          avatar: avatar,
          content: const Loading(size: 20),
          backgroundColor: backgroundColor,
        );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget messageContainer = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: (size.width - ApplicationConstants.chatListWidth) * 0.8,
        minHeight: 40,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: !empty<String>(contentText)
            ? SelectableText(
                contentText!,
                style: textStyle,
                selectionHeightStyle: BoxHeightStyle.max,
                selectionWidthStyle: BoxWidthStyle.max,
                contextMenuBuilder: null,
              )
            : content,
      ),
    );
    if (withContextMenu ?? false) {
      messageContainer = ContextMenuArea(
        width: 200,
        child: messageContainer,
        builder: (context) {
          return [contextMenu!];
        },
      );
    }
    const divider = CustomDivider(
      size: 10,
      direction: DividerDirection.vertical,
    );
    final theme = Provider.of<ThemeVM>(context);
    messageContainer = Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: textDirection,
        children: [
          if (avatar != null) ...[avatar!, divider],
          messageContainer,
          if (showQuoteIcon ?? false) ...[
            divider,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomIconButton(
                icon: Icons.chat_rounded,
                iconColor: theme.darkMode ? Colors.white54 : Colors.black26,
                hoverIconColor: Provider.of<ThemeVM>(context).darkMode
                    ? Colors.white54
                    : Colors.black26,
                hoverColor: Colors.transparent,
                borderRadius: BorderRadius.circular(12.0),
                tooltip: S.of(context).btnClickToShowQuote,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MessageContextDialog(
                          quoteMessages: quoteMessages ?? []);
                    },
                  );
                },
              ),
            ),
          ],
          if (hasError ?? false) ...[
            const CustomDivider(
              size: 10,
              color: Colors.transparent,
              direction: DividerDirection.vertical,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomIconButton(
                icon: Icons.error,
                iconColor: Colors.red,
                hoverIconColor: Colors.red,
                hoverColor: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                tooltip: 'Send error with message: $error',
                onPressed: onErrorIconPressed,
              ),
            ),
          ]
        ],
      ),
    );
    if (selectable ?? false) {
      messageContainer = SelectWrapper(
        checked: selected ?? false,
        onChanged: onSelectChanged,
        child: messageContainer,
      );
    }
    return messageContainer;
  }
}
