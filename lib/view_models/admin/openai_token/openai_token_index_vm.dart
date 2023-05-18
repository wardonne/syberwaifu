import 'package:flutter/material.dart';
import 'package:syberwaifu/components/table/date_cell.dart';
import 'package:syberwaifu/components/table/number_cell.dart';
import 'package:syberwaifu/components/table/text_cell.dart';
import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/services/openai_token_service.dart';
import 'package:syberwaifu/types/chat_list_conditions.dart';
import 'package:syberwaifu/views/admin/openai_token/components/edit_button.dart';
import 'package:syberwaifu/views/admin/openai_token/components/view_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OpenAITokenIndexVM extends DataGridSource {
  final BuildContext context;
  final _openAITokenService = OpenAITokenService();
  OpenAITokenIndexVM(this.context) {
    sortedColumns.add(const SortColumnDetails(
      name: 'CREATED_AT',
      sortDirection: DataGridSortDirection.ascending,
    ));
    fetchOpenAITokenList();
  }

  bool loading = true;

  bool loadingData = true;

  final List<OpenAITokenModel> _openAITokens = [];

  final Map<OpenAITokenModel, int> _openAITokenChatCounts = {};

  int total = 0;

  int page = 1;

  int pageSize = 10;

  int get totalPage => (total / pageSize).ceil();

  @override
  List<DataGridRow> get rows => _openAITokens.map((item) {
        return DataGridRow(cells: [
          DataGridCell<String>(columnName: 'UUID', value: item.uuid),
          DataGridCell<String>(columnName: 'NAME', value: item.name),
          DataGridCell<String>(columnName: 'TOKEN', value: item.token),
          DataGridCell<OpenAITokenModel>(columnName: 'CHAT_COUNT', value: item),
          DataGridCell<DateTime>(
              columnName: 'CREATED_AT', value: item.createdAt),
          DataGridCell<DateTime>(
              columnName: 'UPDATED_AT', value: item.updatedAt),
          DataGridCell<OpenAITokenModel>(columnName: 'ACTIONS', value: item),
        ]);
      }).toList();

  fetchOpenAITokenList() async {
    loadingData = true;
    final sortedColumnDetail = sortedColumns.first;
    final sortedColumn = sortedColumnDetail.name;
    final sortedType =
        sortedColumnDetail.sortDirection == DataGridSortDirection.ascending
            ? DatabaseSortType.asc
            : DatabaseSortType.desc;
    final data = await _openAITokenService.paginate(
      page: page,
      pageSize: pageSize,
      sortedColumn: sortedColumn,
      sortedType: sortedType,
    );
    total = data.total;
    _openAITokens.clear();
    for (final item in data.items) {
      _openAITokens.add(item);
      _openAITokenChatCounts[item] = await item.chatCount;
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
        case 'TOKEN':
          return TextCell(value: cell.value as String);
        case 'CHAT_COUNT':
          final value = cell.value as OpenAITokenModel;
          final chatCount = _openAITokenChatCounts[value] ?? 0;
          return NumberCell(
            value: chatCount,
            clickable: chatCount > 0,
            onPressed: chatCount > 0
                ? () {
                    forward(
                      context,
                      RouterSettings.chatIndex,
                      arguments: ChatListConditions(
                        openAIToken: value,
                      ),
                    );
                  }
                : null,
          );
        case 'CREATED_AT':
        case 'UPDATED_AT':
          return DateCell(dateTime: cell.value as DateTime);
        case 'ACTIONS':
          final value = cell.value as OpenAITokenModel;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ViewButton(value: value),
              EditButton(value: value),
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
    await fetchOpenAITokenList();
  }

  setPage(int newPage) async {
    loadingData = true;
    page = newPage;
    await fetchOpenAITokenList();
  }

  reload() async {
    await setPage(1);
  }
}
