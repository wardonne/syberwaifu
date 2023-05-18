import 'package:flutter/material.dart';
import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/services/chat/chat_service.dart';

class ChatListVM extends ChangeNotifier {
  final _chatService = ChatService();
  ChatListVM(ChatModel? activeChat) {
    fetchChatList().then((value) {
      if (!empty(activeChat)) {
        _activeChat = _chats.firstWhere((item) => item.uuid == activeChat!.uuid,
            orElse: () => _chats.first);
      } else {
        _activeChat = _chats.first;
      }
      notifyListeners();
    });
  }

  late ChatModel _activeChat;

  set activeChat(ChatModel value) {
    _activeChat = value;
    notifyListeners();
  }

  ChatModel get activeChat => _activeChat;

  final List<ChatModel> _chats = [];

  List<ChatModel> get chats {
    return _chats.where((item) {
      if (!empty<String>(_chatName)) {
        return item.name!.contains(_chatName);
      }
      return true;
    }).toList();
  }

  final Map<ChatModel, bool> _chatAvaliable = {};

  bool _loading = false;

  bool get loading => _loading;

  String _chatName = '';

  set chatName(String value) {
    _chatName = value;
    notifyListeners();
  }

  String get chatName => _chatName;

  Future<void> fetchChatList() async {
    _loading = true;
    notifyListeners();
    final data = await _chatService.paginate(
      sortedColumn: 'LAST_CHATED_AT',
      sortedType: DatabaseSortType.desc,
    );
    for (final item in data.items) {
      _chats.add(item);
      _chatAvaliable[item] = await item.avaliable;
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> reload() async {
    await fetchChatList();
  }

  void refreshItemAndSort(ChatModel chat) {
    final index = _chats.indexWhere((item) => item.uuid == chat.uuid);
    _chats[index] = chat;
    _chats.sort((a, b) => b.lastChatedAt!.compareTo(a.lastChatedAt!));
    notifyListeners();
  }

  Future<void> deleteChat(ChatModel chat) async {
    await _chatService.delete(chat.uuid!);
  }
}
