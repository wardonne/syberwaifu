import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/chat/chat_list_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/chat/components/new_chat_button.dart';

class ChatListHeader extends StatelessWidget {
  const ChatListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Consumer2<ChatListVM, ThemeVM>(
      builder: (context, vm, theme, child) {
        searchController.value = TextEditingValue(
            text: vm.chatName,
            selection: TextSelection.collapsed(offset: vm.chatName.length));
        return Container(
          width: ApplicationConstants.chatListWidth,
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: theme.forecolor),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  style: TextStyle(color: theme.forecolor),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.background,
                    hintText: S.of(context).hintSearchChat,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: theme.forecolor,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.forecolor,
                    ),
                    suffixIcon: !empty<String>(searchController.value.text)
                        ? InkWell(
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: theme.forecolor,
                            ),
                            onTap: () {
                              vm.chatName = '';
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.all(10.0),
                    isDense: true,
                    filled: true,
                  ),
                  onChanged: (value) {
                    vm.chatName = value;
                  },
                ),
              ),
              const SizedBox(width: 40.0, child: NewChatButton()),
            ],
          ),
        );
      },
    );
  }
}
