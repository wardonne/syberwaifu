import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/services/database_execute_service.dart';
import 'package:syberwaifu/types/paginated_list.dart';

class OpenAITokenService extends DatabaseExecuteService {
  Future<OpenAITokenModel> create(OpenAITokenModel model) async {
    return await model.create(transaction);
  }

  Future<OpenAITokenModel> update(OpenAITokenModel model) async {
    return model.update<OpenAITokenModel>(transaction);
  }

  Future<List<OpenAITokenModel>> list() async {
    return await OpenAITokenModel.query()
        .findAll<OpenAITokenModel>(transaction);
  }

  Future<OpenAITokenModel> detail(String uuid) async {
    return await OpenAITokenModel.query()
        .findOrFail<OpenAITokenModel>(pk: uuid, txn: transaction);
  }

  Future<int> count() async {
    return await OpenAITokenModel.query().count(transaction);
  }

  Future<PaginatedList<OpenAITokenModel>> paginate({
    required int page,
    required int pageSize,
    String sortedColumn = 'CREATED_AT',
    DatabaseSortType sortedType = DatabaseSortType.asc,
  }) async {
    final query = OpenAITokenModel.query();
    query.limit = pageSize;
    query.offset = pageSize * (page - 1);
    query.orderBy = '$sortedColumn ${sortedType.code}';
    return PaginatedList(
      total: await count(),
      items: await query.findAll<OpenAITokenModel>(transaction),
    );
  }
}
