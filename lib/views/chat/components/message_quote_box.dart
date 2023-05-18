import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_icon_button.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/chat/chat_messages_vm.dart';

class MessageQuoteBox extends StatefulWidget {
  const MessageQuoteBox({super.key});

  @override
  State<StatefulWidget> createState() {
    return MessageQuoteBoxState();
  }
}

class MessageQuoteBoxState extends State<MessageQuoteBox> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ChatMessagesVM>(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black26)),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    S.of(context).btnQuote,
                    textScaleFactor: 1.0,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CustomIconButton(
                icon: Icons.close,
                iconSize: 12,
                buttonWidth: 14,
                buttonHeight: 14,
                borderRadius: BorderRadius.circular(7.0),
                hoverColor: Colors.red,
                hoverIconColor: Colors.white,
                onPressed: () => vm.quoteMessages = [],
              ),
            ],
          ),
          SizedBox(
            height: 40,
            child: SingleChildScrollView(
              child: Column(
                children: vm.quoteMessages
                    .map(
                      (e) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 3),
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          e.content!,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
