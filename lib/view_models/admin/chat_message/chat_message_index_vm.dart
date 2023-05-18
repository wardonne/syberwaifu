import 'package:flutter/material.dart';
import 'package:syberwaifu/components/dialogs/message_context_dialog.dart';
import 'package:syberwaifu/components/table/date_cell.dart';
import 'package:syberwaifu/components/table/number_cell.dart';
import 'package:syberwaifu/components/table/text_cell.dart';
import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/services/chat/chat_message_service.dart';
import 'package:syberwaifu/types/chat_message_list_conditions.dart';
import 'package:syberwaifu/views/admin/chat_message/components/delete_button.dart';
import 'package:syberwaifu/views/admin/chat_message/components/view_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ChatMessageIndexVM extends DataGridSource {
  final BuildContext context;
  final _chatMessageService = ChatMessageService();
  ChatMessageIndexVM(this.context, this.conditions) {
    sortedColumns.add(const SortColumnDetails(
        name: 'CREATED_AT', sortDirection: DataGridSortDirection.ascending));
    fetchChatMessageList();
  }

  final ChatMessageListConditions? conditions;

  bool loading = true;

  bool loadingData = true;

  final List<ChatMessageModel> _messages = [];

  final Map<ChatMessageModel, List<ChatMessageModel>> _messageQuotes = {};

  int total = 0;

  int page = 1;

  int pageSize = 10;

  int get totalPage => (total / pageSize).ceil();

  @override
  List<DataGridRow> get rows => _messages.map((ChatMessageModel model) {
        return DataGridRow(cells: [
          DataGridCell<String>(columnName: 'UUID', value: model.uuid),
          DataGridCell<String>(columnName: 'ROLE', value: model.role),
          DataGridCell<String>(columnName: 'CONTENT', value: model.content),
          DataGridCell<ChatMessageModel>(
              columnName: 'QUOTE_COUNT', value: model),
          DataGridCell<DateTime>(
              columnName: 'CREATED_AT', value: model.createdAt),
          DataGridCell<ChatMessageModel>(columnName: 'ACTIONS', value: model),
        ]);
      }).toList();

  fetchChatMessageList() async {
    loadingData = true;
    final sortedColumnDetail = sortedColumns.first;
    final sortedColumn = sortedColumnDetail.name;
    final sortedType =
        sortedColumnDetail.sortDirection == DataGridSortDirection.ascending
            ? DatabaseSortType.asc
            : DatabaseSortType.desc;
    final data = await _chatMessageService.paginate(
      page: page,
      pageSize: pageSize,
      conditions: conditions,
      sortedColumn: sortedColumn,
      sortedType: sortedType,
    );
    total = data.total;
    notifyListeners();
    _messages.clear();
    for (final message in data.items) {
      _messages.add(message);
      _messageQuotes[message] = await message.quotes;
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
        case 'ROLE':
        case 'CONTENT':
          return TextCell(value: cell.value as String);
        case 'QUOTE_COUNT':
          final value = cell.value as ChatMessageModel;
          final quotes = _messageQuotes[value] ?? [];
          return NumberCell(
            value: quotes.length,
            clickable: quotes.isNotEmpty,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return MessageContextDialog(
                    quoteMessages: quotes,
                  );
                },
              );
            },
          );
        case 'CREATED_AT':
          return DateCell(dateTime: cell.value as DateTime);
        case 'ACTIONS':
          final value = cell.value as ChatMessageModel;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ViewButton(chatMessage: value),
              DeleteButton(chatMessage: value),
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
    await fetchChatMessageList();
  }

  setPage(int newPage) async {
    page = newPage;
    await fetchChatMessageList();
    return true;
  }

  Future<void> reload() async {
    await setPage(1);
  }

  deleteMessage(ChatMessageModel chatMessage) async {
    await _chatMessageService.delete(chatMessage);
  }
}
