import 'package:chat_gpt_sdk/chat_gpt_sdk.dart' show ChatCTResponse;
import 'package:flutter/foundation.dart';
import 'package:syberwaifu/constants/assets.dart';
import 'package:syberwaifu/constants/chat_message.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/services/chat/chat_message_service.dart';
import 'package:syberwaifu/services/chat/chat_service.dart';
import 'package:syberwaifu/services/chat/quote_clip_service.dart';
import 'package:syberwaifu/services/chatgpt_service.dart';
// ignore: implementation_imports
import 'package:chat_gpt_sdk/src/client/exception/request_error.dart';
import 'package:syberwaifu/services/settings/settings_service.dart';

class ChatMessagesVM extends ChangeNotifier with DiagnosticableTreeMixin {
  final _chatMessageService = ChatMessageService();
  final _chatService = ChatService();
  final _quoteClipService = QuoteClipService();
  final _settingsService = SettingsService();
  late ChatGPTService _chatGPTService;

  bool _loading = true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  bool _loadingMore = false;

  set loadingMore(bool value) {
    _loadingMore = value;
    notifyListeners();
  }

  bool get loadingMore => _loadingMore;

  Function? scrollCallback;

  final int _pageSize = 10;

  final List<ChatMessageModel> _messages = List.empty(growable: true);

  List<ChatMessageModel> get messages => _messages;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  String get chatId => _chat.uuid!;

  ChatModel _chat;

  ChatModel get chat => _chat;

  late final AvatarModel? _avatar;

  String get avatar => _avatar?.uri ?? AssetsConstants.defaultAIAvatar;

  late PresetModel _preset;

  PresetModel get preset => _preset;

  List<ChatMessageModel> _quoteMessages = [];

  set quoteMessages(List<ChatMessageModel> value) {
    _quoteMessages = value;
    if (multiSelectMode) {
      multiSelectMode = false;
    }
    notifyListeners();
  }

  List<ChatMessageModel> get quoteMessages => _quoteMessages;

  ChatMessagesVM(this._chat) {
    loadMessage().then((value) async {
      final token = (await _chat.openAIToken).token!;
      _avatar = await _chat.avatar;
      String? proxy;
      if (await _settingsService.checkProxyEnabled()) {
        proxy = await _settingsService.proxySettings();
      }
      _chatGPTService = ChatGPTService(token, proxy: proxy);
      _preset = await chat.preset;
      loading = false;
    });
  }

  Future<void> loadMessage() async {
    final models = await _chatMessageService.list(
      chatId,
      limit: _pageSize,
      offset: _messages.length,
    );
    for (var model in models) {
      _messages.add(model);
      if (model.requestResult == ChatMessageConstants.failed) {
        errors[model.uuid!] = model.requestFailedReason!;
      }
      final quotes = await model.quotes;
      if (!empty<List>(quotes)) {
        cachedQuoteMessages[model.uuid!] = quotes;
      }
    }
    if (hasMore && !empty<List>(_messages)) {
      _hasMore = await _chatMessageService.hasMore(messages.last);
    }
  }

  bool _loadingReponse = false;

  set loadingResponse(bool value) {
    _loadingReponse = value;
    notifyListeners();
  }

  bool get loadingResponse => _loadingReponse;

  Future<ChatMessageModel> createMessage(String content,
      [String role = ChatMessageConstants.user]) async {
    return await Model.transaction<ChatMessageModel>((txn) async {
      String? quoteClipId;

      if (quoteMessages.isNotEmpty) {
        _quoteClipService.beginTransaction(txn);
        final quoteClip = await _quoteClipService.create(quoteMessages);
        quoteClipId = quoteClip.uuid;
        _quoteClipService.endTransaction();
      }

      _chatMessageService.beginTransaction(txn);
      final message = await _chatMessageService.create(
        chatId: chatId,
        role: role,
        content: content,
        sendContent: role != ChatMessageConstants.user
            ? (role == ChatMessageConstants.system ? content : '')
            : '${preset.nickname},$content',
        quoteClipId: quoteClipId,
      );
      _chatMessageService.endTransaction();

      _messages.insert(0, message);

      _chatService.beginTransaction(txn);
      _chat.lastChatedAt = DateTime.now();
      _chat = await _chatService.update(_chat);
      _chatService.endTransaction();
      return message;
    });
  }

  sendMessage(ChatMessageModel message, [bool isResend = false]) async {
    final contextMessages = (await preset.messages)
        .map((e) => {'content': e.content!, 'role': e.role!})
        .toList();

    if (!isResend) {
      contextMessages.addAll(_quoteMessages.map((e) => {
            'content': e.role == ChatMessageConstants.user
                ? e.sendContent!
                : e.content!,
            'role': e.role!,
          }));
    } else {
      final quotes = await message.quotes;
      if (quotes.isNotEmpty) {
        cachedQuoteMessages[message.uuid!] = quotes;
        contextMessages.addAll(quotes.map((e) => {
              'content': e.role == ChatMessageConstants.user
                  ? e.sendContent!
                  : e.content!,
              'role': e.role!,
            }));
      }
    }

    quoteMessages = [];

    loadingResponse = true;

    contextMessages.add({
      'content': message.sendContent!,
      'role': message.role!,
    });

    late final ChatCTResponse? response;
    try {
      response = await _chatGPTService.send(contextMessages);
      if (isResend) {
        errors.remove(message.uuid);
        message.requestResult = ChatMessageConstants.successed;
        message.requestFailedReason = null;
        await _chatMessageService.update(message);
      }
    } on RequestError catch (error) {
      debugPrint('$error');
      errors[message.uuid!] = error.toString();
      message.requestResult = ChatMessageConstants.failed;
      message.requestFailedReason = error.toString();
      await _chatMessageService.update(message);
      loadingResponse = false;
      return;
    }

    final responseChoise = response!.choices.first;

    await createMessage(
        responseChoise.message.content, responseChoise.message.role);

    _quoteMessages = [];

    loadingResponse = false;
  }

  Future<void> deleteMessage(List<ChatMessageModel> items) async {
    await Model.transaction((txn) async {
      _chatMessageService.beginTransaction(txn);
      for (var item in items) {
        await _chatMessageService.delete(item);
      }
      _chatMessageService.endTransaction();
    });
    messages.removeWhere((element) => items.contains(element));
    notifyListeners();
  }

  bool _multiSelectMode = false;

  set multiSelectMode(bool value) {
    _multiSelectMode = value;
    if (!value) {
      _selectedMessages = [];
    } else {
      _quoteMessages = [];
    }
    notifyListeners();
  }

  bool get multiSelectMode => _multiSelectMode;

  List<ChatMessageModel> _selectedMessages = [];

  List<ChatMessageModel> get selectedMessages => _selectedMessages;

  final int maxSelect = 10;

  void selectMessage(ChatMessageModel message) {
    if (!multiSelectMode) return;
    _selectedMessages.add(message);
    notifyListeners();
  }

  void unselectMessage(ChatMessageModel message) {
    if (!multiSelectMode) return;
    _selectedMessages.remove(message);
    notifyListeners();
  }

  final Map<String, String> errors = {};

  void quote(ChatMessageModel message, [bool withContext = false]) async {
    final quoteMessageList = <ChatMessageModel>[];
    if (withContext) {
      final quotes = await message.quotes;
      quoteMessageList.addAll(quotes);
    }
    quoteMessageList.add(message);
    quoteMessages = quoteMessageList;
  }

  final cachedQuoteMessages = <String, List<ChatMessageModel>>{};
}
