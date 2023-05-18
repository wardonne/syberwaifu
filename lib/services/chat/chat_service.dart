import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/services/database_execute_service.dart';
import 'package:syberwaifu/types/chat_list_conditions.dart';
import 'package:syberwaifu/types/paginated_list.dart';

class ChatService with DatabaseExecuteService {
  Future<ChatModel> detail(String uuid) async {
    return await ChatModel.query()
        .findOrFail<ChatModel>(pk: uuid, txn: transaction);
  }

  Future<ChatModel> latestOne() async {
    final queryBuilder = ChatModel.query()..orderBy = 'LAST_CHATED_AT DESC';
    return await queryBuilder.findOrFail<ChatModel>();
  }

  Future<ChatModel> create(ChatModel chat) async {
    return await chat.create<ChatModel>(transaction);
  }

  Future<ChatModel> update(ChatModel chat) async {
    return await chat.update<ChatModel>(transaction);
  }

  Future<void> delete(String uuid) async {
    final chat = await ChatModel.query()
        .findOrFail<ChatModel>(pk: uuid, txn: transaction);
    await chat.delete(transaction);
  }

  Future<int> count({ChatListConditions? conditions}) async {
    final query = ChatModel.query();
    if (!empty(conditions?.preset)) {
      query.wherePresetId(conditions!.preset!.uuid!);
    }
    if (!empty(conditions?.openAIToken)) {
      query.whereOpenAITokenId(conditions!.openAIToken!.uuid);
    }
    if (!empty<String>(conditions?.name)) {
      query.whereNameContains(conditions!.name!);
    }
    return await query.count(transaction);
  }

  Future<PaginatedList<ChatModel>> paginate({
    int? page,
    int? pageSize,
    ChatListConditions? conditions,
    String sortedColumn = 'CREATED_AT',
    DatabaseSortType sortedType = DatabaseSortType.asc,
  }) async {
    final query = ChatModel.query();
    if (!empty(conditions?.preset)) {
      query.wherePresetId(conditions!.preset!.uuid!);
    }
    if (!empty(conditions?.openAIToken)) {
      query.whereOpenAITokenId(conditions!.openAIToken!.uuid);
    }
    if (!empty<String>(conditions?.name)) {
      query.whereNameContains(conditions!.name!);
    }
    if ((pageSize ?? 0) > 0) {
      query.offset = pageSize! * ((page ?? 1) - 1);
      query.limit = pageSize;
    }
    query.orderBy = '$sortedColumn ${sortedType.code}';
    return PaginatedList(
      total: (pageSize ?? 0) > 0 ? await count(conditions: conditions) : 0,
      items: await query.findAll<ChatModel>(transaction),
    );
  }
}
