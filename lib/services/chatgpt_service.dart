import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:syberwaifu/functions/empty.dart';

class ChatGPTService {
  OpenAI? client;
  ChatGPTService(String token, {String? proxy}) {
    final options = HttpSetup(
      receiveTimeout: const Duration(seconds: 30),
    );
    if (!empty(proxy)) {
      options.proxy = "PROXY $proxy";
    }
    client = OpenAI.instance.build(
      token: token,
      baseOption: options,
      isLog: kDebugMode,
    );
  }

  Future<ChatCTResponse?> send(List<Map<String, String>> messages) async {
    final request = ChatCompleteText(
      messages: messages,
      maxToken: 1000,
      model: ChatModel.ChatGptTurbo0301Model,
    );
    final response = await client!.onChatCompletion(request: request);
    return response;
  }

  Future draw() async {}
}
