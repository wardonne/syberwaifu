import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/services/database_execute_service.dart';
import 'package:syberwaifu/types/paginated_list.dart';

class AvatarService extends DatabaseExecuteService {
  Future<int> count() async {
    final query = AvatarModel.query();
    return await query.count(transaction);
  }

  Future<PaginatedList<AvatarModel>> paginate({
    int? page,
    int? pageSize,
    String sortedColumn = 'CREATED_AT',
    DatabaseSortType sortedType = DatabaseSortType.desc,
  }) async {
    final query = AvatarModel.query();
    if (!empty<int>(pageSize)) {
      query.limit = pageSize!;
      query.offset = pageSize * ((page ?? 1) - 1);
    }
    query.orderBy = '$sortedColumn ${sortedType.code}';
    return PaginatedList(
      total: await count(),
      items: await query.findAll<AvatarModel>(transaction),
    );
  }

  Future<void> delete(AvatarModel model) async {
    return model.delete(transaction);
  }

  Future<AvatarModel> create(AvatarModel model) async {
    return await model.create(transaction);
  }
}
