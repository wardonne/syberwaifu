import 'package:syberwaifu/constants/preset.dart';
import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/services/database_execute_service.dart';
import 'package:syberwaifu/types/paginated_list.dart';

class PresetService extends DatabaseExecuteService {
  Future<PresetModel> defaultPreset() async {
    return await (PresetModel.query()
          ..whereIsDefault(PresetConstants.isDefault))
        .findOrFail(txn: transaction);
  }

  Future<List<PresetModel>> list({int? page, int? pageSize}) async {
    final queryBuilder = PresetModel.query();
    if (page != null && pageSize != null) {
      queryBuilder.limit = pageSize;
      queryBuilder.offset = pageSize * (page - 1);
    }
    return await PresetModel.query().findAll<PresetModel>();
  }

  Future<PresetModel> detail(String uuid) async {
    return await PresetModel.query()
        .findOrFail<PresetModel>(pk: uuid, txn: transaction);
  }

  Future<PresetModel> create(PresetModel preset) async {
    return await preset.create<PresetModel>(transaction);
  }

  Future<int> count() async {
    return PresetModel.query().count(transaction);
  }

  Future<PaginatedList<PresetModel>> paginate({
    required int page,
    required int pageSize,
    String sortedColumn = 'CREATED_AT',
    DatabaseSortType sortedType = DatabaseSortType.asc,
  }) async {
    final query = PresetModel.query();
    query.limit = pageSize;
    query.offset = pageSize * (page - 1);
    query.orderBy = '$sortedColumn ${sortedType.code}';
    return PaginatedList(
      total: await count(),
      items: await query.findAll<PresetModel>(transaction),
    );
  }

  Future<PresetModel> update(PresetModel preset) async {
    return await preset.update(transaction);
  }

  Future<void> delete(String presetId) async {
    final query = PresetModel.query()..where('UUID', presetId);
    await query.delete(transaction);
  }
}
