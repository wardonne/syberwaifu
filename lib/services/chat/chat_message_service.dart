import 'package:syberwaifu/enums/database_sort_type.dart';
import 'package:syberwaifu/enums/database_where_operator.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/services/chat/quote_clip_service.dart';
import 'package:syberwaifu/services/database_execute_service.dart';
import 'package:syberwaifu/types/chat_message_list_conditions.dart';
import 'package:syberwaifu/types/paginated_list.dart';

class ChatMessageService extends DatabaseExecuteService {
  Future<List<ChatMessageModel>> list(String chatId,
      {int offset = 0,
      int limit = 10,
      String orderBy = 'CREATED_AT DESC'}) async {
    final queryBuilder = ChatMessageModel.query()
      ..whereChatId(chatId)
      ..limit = limit
      ..offset = offset
      ..orderBy = orderBy;
    return await queryBuilder.findAll<ChatMessageModel>(transaction);
  }

  Future<ChatMessageModel> create({
    required String chatId,
    required String role,
    required String content,
    String sendContent = '',
    String? quoteClipId,
  }) async {
    return await ChatMessageModel(
      chatId: chatId,
      role: role,
      content: content,
      sendContent: sendContent,
      quoteClipId: quoteClipId,
    ).create(transaction);
  }

  Future<ChatMessageModel> update(ChatMessageModel message) async {
    return await message.update<ChatMessageModel>(transaction);
  }

  Future<bool> hasMore(ChatMessageModel message) async {
    final queryBuilder = ChatMessageModel.query()
      ..whereChatId(message.chatId!)
      ..where(
        'CREATED_AT',
        message.createdAt!.millisecondsSinceEpoch,
        operator: DatabaseWhereOperator.lt,
      );
    final count = await queryBuilder.count(transaction);
    return count > 0;
  }

  Future<void> deleteByChatId(String chatId) async {
    final query = ChatMessageModel.query();
    query.whereChatId(chatId);
    final messages = await query.findAll<ChatMessageModel>(transaction);
    for (var message in messages) {
      await delete(message);
    }
  }

  Future<void> delete(ChatMessageModel model) async {
    final quoteClipId = model.quoteClipId;
    await model.delete(transaction);
    if (!empty<String>(quoteClipId)) {
      final quoteClipService = QuoteClipService();
      if (transaction != null) {
        quoteClipService.beginTransaction(transaction!);
      }
      await quoteClipService.delete(quoteClipId!);
      if (transaction != null) {
        quoteClipService.endTransaction();
      }
    }
  }

  Future<int> count({ChatMessageListConditions? conditions}) async {
    final query = ChatMessageModel.query();
    if (!empty(conditions?.chat)) {
      query.whereChatId(conditions!.chat!.uuid!);
    }
    if (!empty<String>(conditions?.keyword)) {
      query.whereContains(conditions!.keyword!);
    }
    if (!empty<String>(conditions?.role)) {
      query.where('ROLE', conditions!.role!);
    }
    return query.count(transaction);
  }

  Future<PaginatedList<ChatMessageModel>> paginate({
    required int page,
    required int pageSize,
    ChatMessageListConditions? conditions,
    String? sortedColumn,
    DatabaseSortType? sortedType,
  }) async {
    final total = await count(conditions: conditions);
    final query = ChatMessageModel.query();
    if (!empty(conditions?.chat)) {
      query.whereChatId(conditions!.chat!.uuid!);
    }
    if (!empty<String>(conditions?.keyword)) {
      query.whereContains(conditions!.keyword!);
    }
    if (!empty<String>(conditions?.role)) {
      query.where('ROLE', conditions!.role!);
    }
    if (!empty<String>(sortedColumn)) {
      query.orderBy = '$sortedColumn ${sortedType?.code ?? 'ASC'}';
    }
    query.limit = pageSize;
    query.offset = pageSize * (page - 1);
    return PaginatedList(
      total: total,
      items: await query.findAll<ChatMessageModel>(transaction),
    );
  }
}
