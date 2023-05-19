import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syberwaifu/components/chat_avatar.dart';
import 'package:syberwaifu/components/table/date_cell.dart';
import 'package:syberwaifu/components/table/number_cell.dart';
import 'package:syberwaifu/components/table/text_cell.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/functions/file.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/services/avatar_service.dart';
import 'package:syberwaifu/types/chat_list_conditions.dart';
import 'package:syberwaifu/views/admin/avatar/components/delete_button.dart';
import 'package:syberwaifu/views/admin/avatar/components/view_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:uuid/uuid.dart';

class AvatarIndexVM extends DataGridSource {
  final BuildContext context;
  final _avatarService = AvatarService();
  AvatarIndexVM(this.context, {bool isPopup = false}) : _isPopup = isPopup {
    _loading = true;
    sortedColumns.add(
      const SortColumnDetails(
          name: 'CREATED_AT', sortDirection: DataGridSortDirection.descending),
    );
    fetchAvatarList();
  }

  final bool _isPopup;

  bool get isPopup => _isPopup;

  final _avatarChatCounts = <AvatarModel, int>{};

  final _models = <AvatarModel>[];

  List<AvatarModel> get models => _models;

  AvatarModel? selectedAvatar;

  @override
  List<DataGridRow> get rows => models.map((model) {
        return DataGridRow(cells: <DataGridCell>[
          if (_isPopup)
            DataGridCell<AvatarModel>(columnName: 'CHECKBOX', value: model),
          DataGridCell<String>(columnName: 'UUID', value: model.uuid),
          DataGridCell<String>(columnName: 'URI', value: model.uri),
          if (!_isPopup)
            DataGridCell<AvatarModel>(columnName: 'CHAT_COUNT', value: model),
          DataGridCell<DateTime>(
              columnName: 'CREATED_AT', value: model.createdAt),
          DataGridCell<AvatarModel>(columnName: 'ACTIONS', value: model),
        ]);
      }).toList();

  int total = 0;

  int _page = 1;

  set page(int value) {
    if (_page != value) {
      selectedAvatar = null;
    }
    _page = value;
  }

  int get page => _page;

  int pageSize = 10;

  int get totalPage => (total / pageSize).ceil();

  bool _loading = false;

  bool get loading => _loading;

  bool _loadingData = false;

  set loadingData(bool value) {
    _loadingData = value;
    notifyListeners();
  }

  bool get loadingData => _loadingData;

  Future<void> fetchAvatarList() async {
    loadingData = true;
    final sortedColumnDetail = sortedColumns.first;
    final sortedColumn = sortedColumnDetail.name;
    final sortedType =
        sortedColumnDetail.sortDirection == DataGridSortDirection.ascending
            ? DatabaseSortType.asc
            : DatabaseSortType.desc;
    final data = await _avatarService.paginate(
      page: page,
      pageSize: pageSize,
      sortedColumn: sortedColumn,
      sortedType: sortedType,
    );
    total = data.total;
    _models.clear();
    for (final item in data.items) {
      _models.add(item);
      if (!_isPopup) {
        _avatarChatCounts[item] = await item.chatCount;
      }
    }
    _loading = false;
    loadingData = false;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      switch (cell.columnName) {
        case 'CHECKBOX':
          final model = cell.value as AvatarModel;
          return Checkbox(
              value: selectedAvatar?.uuid == model.uuid,
              onChanged: (bool? value) {
                if (value == null) return;
                if (value) {
                  selectedAvatar = model;
                  notifyListeners();
                } else {
                  selectedAvatar = null;
                  notifyListeners();
                }
              });
        case 'UUID':
          return TextCell(value: cell.value as String);
        case 'URI':
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatAvatar.small(avatar: cell.value as String),
          );
        case 'CHAT_COUNT':
          final avatar = cell.value as AvatarModel;
          final chatCount = _avatarChatCounts[avatar] ?? 0;
          return NumberCell(
            value: chatCount,
            clickable: chatCount > 0 && !_isPopup,
            onPressed: () async {
              await forward(context, RouterSettings.chatIndex,
                  arguments: ChatListConditions(avatar: avatar));
              fetchAvatarList();
            },
          );
        case 'CREATED_AT':
          return DateCell(dateTime: cell.value as DateTime);
        case 'ACTIONS':
          final avatar = cell.value as AvatarModel;
          final chatCount = _avatarChatCounts[avatar] ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ViewButton(avatar: cell.value as AvatarModel),
              if (chatCount == 0) DeleteButton(avatar: avatar),
            ],
          );
        default:
          return Container();
      }
    }).toList());
  }

  setPage(int newPage) async {
    loadingData = true;
    notifyListeners();
    page = newPage;
    await fetchAvatarList();
    loadingData = false;
  }

  @override
  Future<void> sort() async {
    _loading = true;
    page = 1;
    await fetchAvatarList();
  }

  void refresh() async {
    await fetchAvatarList();
  }

  Future<void> reload() async {
    _loading = true;
    page = 1;
    await fetchAvatarList();
  }

  Future<void> create(String tempUri) async {
    final ext = extension(tempUri);
    final documentPath = await getApplicationDocumentsDirectory();
    final avatarPath = joinAll([
      documentPath.path,
      ApplicationConstants.avatarDirpath,
      '${const Uuid().v4()}$ext',
    ]);
    final avatar = await rename(tempUri, avatarPath);
    final model = AvatarModel(uri: 'file://${avatar.path}');
    await _avatarService.create(model);
  }

  Future<void> delete(AvatarModel avatar) async {
    return await _avatarService.delete(avatar);
  }
}
