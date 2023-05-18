import 'package:syberwaifu/models/chat/chat_model.dart';

class ChatMessageListConditions extends Object {
  final ChatModel? chat;
  final String? keyword;
  final String? role;
  ChatMessageListConditions({
    this.chat,
    this.keyword,
    this.role,
  });
}
