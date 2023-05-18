import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/dashboard_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/view_models/chat/chat_list_vm.dart';
import 'package:syberwaifu/view_models/chat/chat_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/chat/chat_list.dart';
import 'package:syberwaifu/views/chat/chat_main.dart';
import 'package:syberwaifu/views/chat/components/chat_list_header.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<StatefulWidget> createState() {
    return IndexState();
  }
}

class IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    final activeChat = ModalRoute.of(context)?.settings.arguments as ChatModel?;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatListVM(activeChat)),
        ChangeNotifierProxyProvider<ChatListVM, ChatVM>(
          create: (context) => ChatVM(
              Provider.of<ChatListVM>(context, listen: false).activeChat),
          update: (context, chatListVM, previous) {
            final activeChat = chatListVM.activeChat;
            previous!.chat = activeChat;
            return previous;
          },
        ),
      ],
      child: Consumer2<ThemeVM, ChatListVM>(
        builder: (context, themeVM, chatListVM, child) {
          const loading = Center(child: Loading());
          final vm = Provider.of<ChatListVM>(context);
          if (vm.loading) {
            return loading;
          }
          return Scaffold(
            appBar: CustomAppBar(
              Provider.of<ChatVM>(context).chat.name!,
              leadings: const [
                ChatListHeader(),
              ],
              floatingLeadings: const [
                DashboardButton(),
              ],
            ),
            body: Row(
              children: const [
                ChatList(),
                Expanded(child: ChatMain()),
              ],
            ),
          );
        },
      ),
    );
  }
}
