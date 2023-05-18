import 'package:flutter/widgets.dart';
import 'package:syberwaifu/components/chat_avatar.dart';
import 'package:syberwaifu/components/table/date_cell.dart';
import 'package:syberwaifu/components/table/number_cell.dart';
import 'package:syberwaifu/components/table/text_cell.dart';
import 'package:syberwaifu/constants/assets.dart';
import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/services/chat/chat_message_service.dart';
import 'package:syberwaifu/services/chat/chat_service.dart';
import 'package:syberwaifu/types/chat_list_conditions.dart';
import 'package:syberwaifu/types/chat_message_list_conditions.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_button.dart';
import 'package:syberwaifu/views/admin/chat/components/delete_button.dart';
import 'package:syberwaifu/views/admin/chat/components/edit_button.dart';
import 'package:syberwaifu/views/admin/chat/components/view_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ChatIndexVM extends DataGridSource {
  final BuildContext context;
  final ChatListConditions? conditions;
  final _chatService = ChatService();
  final _chatMessageService = ChatMessageService();
  ChatIndexVM(this.context, {this.conditions}) {
    sortedColumns.add(const SortColumnDetails(
        name: 'LAST_CHATED_AT',
        sortDirection: DataGridSortDirection.descending));
    fetchChatList();
  }

  bool loading = true;

  bool loadingData = true;

  List<ChatModel> _chats = [];

  final Map<ChatModel, AvatarModel?> _chatAvatars = {};

  final Map<ChatModel, PresetModel?> _chatPresets = {};

  final Map<ChatModel, OpenAITokenModel?> _chatOpenAITokens = {};

  final Map<ChatModel, int> _chatMessageCount = {};

  int total = 0;

  int page = 1;

  int pageSize = 10;

  int get totalPage => (total / pageSize).ceil();

  @override
  List<DataGridRow> get rows => _chats.map((ChatModel chat) {
        return DataGridRow(cells: [
          DataGridCell<String>(columnName: 'UUID', value: chat.uuid),
          DataGridCell<String>(columnName: 'NAME', value: chat.name),
          DataGridCell<ChatModel>(columnName: 'AVATAR', value: chat),
          DataGridCell<PresetModel>(
              columnName: 'PRESET', value: _chatPresets[chat]),
          DataGridCell<OpenAITokenModel>(
              columnName: 'OPENAI_TOKEN', value: _chatOpenAITokens[chat]),
          DataGridCell<ChatModel>(columnName: 'MESSAGE_COUNT', value: chat),
          DataGridCell<DateTime>(
              columnName: 'LAST_CHATED_AT', value: chat.lastChatedAt),
          DataGridCell<DateTime>(
              columnName: 'CREATED_AT', value: chat.createdAt),
          DataGridCell<DateTime>(
              columnName: 'UPDATED_AT', value: chat.updatedAt),
          DataGridCell<ChatModel>(columnName: 'ACTIONS', value: chat),
        ]);
      }).toList();

  fetchChatList() async {
    loadingData = true;
    final sortedColumnDetail = sortedColumns.first;
    final sortedColumn = sortedColumnDetail.name;
    final sortedType =
        sortedColumnDetail.sortDirection == DataGridSortDirection.ascending
            ? DatabaseSortType.asc
            : DatabaseSortType.desc;
    final data = await _chatService.paginate(
      page: page,
      pageSize: pageSize,
      conditions: conditions,
      sortedColumn: sortedColumn,
      sortedType: sortedType,
    );
    total = data.total;
    notifyListeners();
    _chats = data.items;
    for (final chat in _chats) {
      _chatPresets[chat] = await chat.preset;
      _chatAvatars[chat] = await chat.avatar;
      _chatOpenAITokens[chat] = await chat.openAIToken;
      _chatMessageCount[chat] = await chat.messageCount;
    }
    loading = false;
    loadingData = false;
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final dataCells = row.getCells();
    final cells = dataCells.map<Widget>((cell) {
      switch (cell.columnName) {
        case 'UUID':
        case 'NAME':
          return TextCell(value: cell.value as String);
        case 'AVATAR':
          final chat = cell.value as ChatModel;
          final avatar = _chatAvatars[chat];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatAvatar.small(
              avatar: avatar?.uri ?? AssetsConstants.defaultAIAvatar,
            ),
          );
        case 'PRESET':
          final value = cell.value as PresetModel;
          return TextCell(
            value: value.name ?? '',
            clickable: !empty(value),
            onPressed: !empty(value)
                ? () {
                    forward(
                      context,
                      RouterSettings.presetDetail,
                      arguments: value,
                    );
                  }
                : null,
          );
        case 'MESSAGE_COUNT':
          final value = cell.value as ChatModel;
          final messageCount = _chatMessageCount[value] ?? 0;
          return NumberCell(
            value: messageCount,
            clickable: messageCount > 0,
            onPressed: () {
              forward(context, RouterSettings.chatMessageIndex,
                  arguments: ChatMessageListConditions(
                    chat: value,
                  ));
            },
          );
        case 'OPENAI_TOKEN':
          final value = cell.value as OpenAITokenModel;
          return TextCell(
            value: value.name ?? '',
            clickable: true,
            onPressed: () {
              forward(context, RouterSettings.openAITokenDetail,
                  arguments: value);
            },
          );
        case 'LAST_CHATED_AT':
        case 'CREATED_AT':
        case 'UPDATED_AT':
          return DateCell(dateTime: cell.value as DateTime);
        case 'ACTIONS':
          final value = cell.value as ChatModel;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChatButton(chat: value),
              ViewButton(chat: value),
              EditButton(chat: value),
              if (total > 1) DeleteButton(chat: value),
            ],
          );
        default:
          return Container();
      }
    }).toList();
    return DataGridRowAdapter(cells: cells);
  }

  @override
  Future<void> sort() async {
    loading = true;
    page = 1;
    await fetchChatList();
  }

  setPage(int newPage) async {
    loadingData = true;
    page = newPage;
    await fetchChatList();
  }

  Future<void> deleteChat(String chatId) async {
    await Model.transaction((txn) async {
      _chatService.beginTransaction(txn);
      await _chatService.delete(chatId);
      _chatService.endTransaction();

      _chatMessageService.beginTransaction(txn);
      await _chatMessageService.deleteByChatId(chatId);
      _chatMessageService.endTransaction();
    });
  }

  reload() async {
    await setPage(1);
  }
}
