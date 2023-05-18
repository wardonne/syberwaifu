import 'package:flutter/material.dart';
import 'package:syberwaifu/components/table/date_cell.dart';
import 'package:syberwaifu/components/table/number_cell.dart';
import 'package:syberwaifu/components/table/text_cell.dart';
import 'package:syberwaifu/constants/preset.dart';
import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/services/preset/preset_message_service.dart';
import 'package:syberwaifu/services/preset/preset_service.dart';
import 'package:syberwaifu/types/chat_list_conditions.dart';
import 'package:syberwaifu/views/admin/preset/components/delete_button.dart';
import 'package:syberwaifu/views/admin/preset/components/edit_button.dart';
import 'package:syberwaifu/views/admin/preset/components/view_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PresetIndexVM extends DataGridSource {
  late final BuildContext context;
  final _presetService = PresetService();
  final _presetMessageService = PresetMessageService();

  bool loading = true;

  bool loadingData = true;

  final Map<PresetModel, int> _presetChatsCount = {};

  List<PresetModel> _items = [];

  @override
  List<DataGridRow> get rows => _items.map((PresetModel model) {
        return DataGridRow(cells: [
          DataGridCell<String>(
            columnName: 'UUID',
            value: model.uuid,
          ),
          DataGridCell<String>(
            columnName: 'NAME',
            value: model.name,
          ),
          DataGridCell<String>(
            columnName: 'NICKNAME',
            value: model.nickname,
          ),
          DataGridCell<int>(
            columnName: 'IS_DEFAULT',
            value: model.isDefault,
          ),
          DataGridCell<PresetModel>(
            columnName: 'CHAT_COUNT',
            value: model,
          ),
          DataGridCell<DateTime>(
            columnName: 'CREATED_AT',
            value: model.createdAt,
          ),
          DataGridCell<DateTime>(
            columnName: 'UPDATED_AT',
            value: model.updatedAt,
          ),
          DataGridCell<PresetModel>(
            columnName: 'ACTIONS',
            value: model,
          ),
        ]);
      }).toList();

  int total = 0;

  int page = 1;

  int pageSize = 10;

  int get totalPage => (total / pageSize).ceil();

  PresetIndexVM(this.context) {
    sortedColumns.add(
      const SortColumnDetails(
        name: 'CREATED_AT',
        sortDirection: DataGridSortDirection.ascending,
      ),
    );
    fetchPresetList();
  }

  Future<void> fetchPresetList() async {
    loadingData = true;
    final sortedColumnDetail = sortedColumns.first;
    final sortedColumn = sortedColumnDetail.name;
    final sortedType =
        sortedColumnDetail.sortDirection == DataGridSortDirection.ascending
            ? DatabaseSortType.asc
            : DatabaseSortType.desc;
    final data = await _presetService.paginate(
      page: page,
      pageSize: pageSize,
      sortedColumn: sortedColumn,
      sortedType: sortedType,
    );
    total = data.total;
    _items = data.items;
    for (final item in _items) {
      _presetChatsCount[item] = await item.chatCount;
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
        case 'NICKNAME':
          return TextCell(value: cell.value as String);
        case 'IS_DEFAULT':
          return TextCell(
            value: S.of(context).columnValueFormatPresetIsDefault(cell.value),
          );
        case 'CHAT_COUNT':
          final value = cell.value as PresetModel;
          return NumberCell(
            value: _presetChatsCount[value] ?? 0,
            clickable: (_presetChatsCount[value] ?? 0) > 0,
            onPressed: () {
              forward(
                context,
                RouterSettings.chatIndex,
                arguments: ChatListConditions(
                  preset: value,
                ),
              );
            },
          );
        case 'CREATED_AT':
        case 'UPDATED_AT':
          return DateCell(dateTime: cell.value);
        case 'ACTIONS':
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ViewButton(preset: cell.value as PresetModel),
              EditButton(preset: cell.value as PresetModel),
              if ((cell.value as PresetModel).isDefault !=
                  PresetConstants.isDefault)
                DeleteButton(preset: cell.value as PresetModel),
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
    await fetchPresetList();
  }

  setPage(int newPage) async {
    loadingData = true;
    page = newPage;
    await fetchPresetList();
    loadingData = false;
  }

  Future<void> deletePreset(PresetModel preset) async {
    await Model.transaction((txn) async {
      _presetService.beginTransaction(txn);
      await _presetService.delete(preset.uuid!);
      _presetService.endTransaction();

      _presetMessageService.beginTransaction(txn);
      await _presetMessageService.deleteByPresetId(preset.uuid!);
      _presetMessageService.endTransaction();
    });
  }

  reload() async {
    await setPage(1);
  }
}
