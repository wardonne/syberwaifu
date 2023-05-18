import 'package:flutter/material.dart';
import 'package:syberwaifu/views/admin/avatar/index.dart';
import 'package:syberwaifu/views/admin/chat/detail.dart';
import 'package:syberwaifu/views/admin/chat/index.dart';
import 'package:syberwaifu/views/admin/chat_message/index.dart';
import 'package:syberwaifu/views/admin/openai_token/detail.dart';
import 'package:syberwaifu/views/admin/openai_token/index.dart';
import 'package:syberwaifu/views/admin/preset/detail.dart';
import 'package:syberwaifu/views/admin/preset/index.dart';
import 'package:syberwaifu/views/index.dart';
import 'package:syberwaifu/views/init_settings.dart';
import 'package:syberwaifu/views/admin/dashboard/index.dart';

class RouterSettings {
  static const chat = '/';
  static const init = '/init';
  static const editChat = '/chat-edit';
  static const dashboard = '/admin/dashboard';
  static const presetIndex = '/admin/presets';
  static const presetDetail = '/admin/presets/detail';
  static const presetCreate = '/admin/presets/create';
  static const presetUpdate = '/admin/presets/update';
  static const chatIndex = '/admin/chats';
  static const chatDetail = '/admin/chats/detail';
  static const chatCreate = '/admin/chats/create';
  static const chatUpdate = '/admin/chats/update';
  static const chatMessageIndex = '/admin/chat-messages';
  static const openAITokenIndex = '/admin/openai-tokens';
  static const openAITokenDetail = '/admin/openai-tokens/detail';
  static const openAITokenCreate = '/admin/openai-tokens/create';
  static const openAITokenUpdate = '/admin/openai-tokens/update';
  static const avatarIndex = '/admin/avatars';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      chat: (context) => const Index(),
      init: (context) => const InitSettings(),
      dashboard: (context) => const Dashboard(),
      presetIndex: (context) => const PresetIndex(),
      presetDetail: (context) => const PresetDetail(),
      presetCreate: (context) => const PresetDetail(),
      presetUpdate: (context) => const PresetDetail(editable: true),
      chatIndex: (context) => const ChatIndex(),
      chatDetail: (context) => const ChatDetail(),
      chatCreate: (context) => const ChatDetail(),
      chatUpdate: (context) => const ChatDetail(editable: true),
      chatMessageIndex: (context) => const ChatMessageIndex(),
      openAITokenIndex: (context) => const OpenAITokenIndex(),
      openAITokenCreate: (context) => const OpenAITokenDetail(),
      openAITokenDetail: (context) => const OpenAITokenDetail(),
      openAITokenUpdate: (context) => const OpenAITokenDetail(editable: true),
      avatarIndex: (context) => const AvatarIndex(),
    };
  }
}
