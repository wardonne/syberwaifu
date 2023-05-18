import 'package:intl/intl.dart';
import 'package:syberwaifu/constants/chat_message.dart';
import 'package:syberwaifu/enums/database_where_operator.dart';
import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/time_util.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/chat/quote_clip_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:uuid/uuid.dart';

class ChatMessageModel extends Model {
  String? _uuid;
  String? chatId;
  String? role;
  String? content;
  String? sendContent;
  int? requestResult;
  String? requestFailedReason;
  String? quoteClipId;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? get uuid => _uuid;

  @override
  String get tableName => 'CHAT_MESSAGES';

  @override
  String get primaryKey => 'UUID';

  @override
  String? get primaryValue => _uuid;

  ChatMessageModel({
    required this.chatId,
    required this.role,
    required this.content,
    required this.sendContent,
    this.quoteClipId,
  })  : _uuid = const Uuid().v4(),
        requestResult = ChatMessageConstants.successed;

  ChatMessageModel.query() : super.query();

  ChatMessageModel.fromJSON(Map<String, Object?> json)
      : _uuid = Arr.get<String>(json, 'UUID'),
        chatId = Arr.get<String>(json, 'CHAT_ID'),
        role = Arr.get<String>(json, 'ROLE'),
        content = Arr.get<String>(json, 'CONTENT'),
        sendContent = Arr.get<String>(json, 'SEND_CONTENT'),
        quoteClipId = Arr.tryGet<String>(json, 'QUOTE_CLIP_ID'),
        requestResult = Arr.tryGet<int>(json, 'REQUEST_RESULT') ??
            ChatMessageConstants.successed,
        requestFailedReason = Arr.tryGet<String>(json, 'REQUEST_FAILED_REASON'),
        createdAt = Arr.getCast<int, DateTime>(
            json, 'CREATED_AT', TimeUtil.fromTimestamp),
        updatedAt = Arr.getCast<int, DateTime>(
            json, 'UPDATED_AT', TimeUtil.fromTimestamp),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() => {
        'UUID': _uuid,
        'CHAT_ID': chatId,
        'ROLE': role,
        'CONTENT': content,
        'SEND_CONTENT': sendContent,
        'REQUEST_RESULT': requestResult ?? ChatMessageConstants.successed,
        'REQUEST_FAILED_REASON': requestFailedReason,
        'QUOTE_CLIP_ID': quoteClipId,
        'CREATED_AT': TimeUtil.timestamp(createdAt),
        'UPDATED_AT': TimeUtil.timestamp(updatedAt),
      };

  Future<ChatModel> get chat async {
    if (!relations.containsKey('chat')) {
      relations['chat'] =
          await ChatModel.query().findOrFail<ChatModel>(pk: chatId!);
    }
    return relations['chat'] as ChatModel;
  }

  Future<List<ChatMessageModel>> get quotes async {
    if (quoteClipId == null) {
      return [];
    }
    final quoteClip =
        await QuoteClipModel.query().find<QuoteClipModel>(pk: quoteClipId);
    if (quoteClip == null) {
      return [];
    }
    final quoteMessages = await quoteClip.messages;
    final messages = <ChatMessageModel>[];
    for (var quoteMessage in quoteMessages) {
      final message = await quoteMessage.message;
      if (!empty<ChatMessageModel>(message)) {
        messages.add(message!);
      }
    }
    return messages;
  }

  Future<int> get quoteCount async {
    return (await quotes).length;
  }

  whereChatId(String value) => where('CHAT_ID', value);

  String get messageTime {
    final now = DateTime.now();
    if (createdAt!.year == now.year) {
      if (createdAt!.month == now.month && createdAt!.day == now.day) {
        return DateFormat('HH:mm').format(createdAt!);
      } else {
        return DateFormat('MM/dd HH:mm').format(createdAt!);
      }
    } else {
      return DateFormat('yyyy/MM/dd HH:mm').format(createdAt!);
    }
  }

  bool hasPasedMinutes(int minutes, DateTime? from) {
    return (from ?? DateTime.now()).difference(createdAt!).inMinutes.abs() >=
        minutes;
  }

  bool isSendByUser() {
    return role! == ChatMessageConstants.user;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeInsert => _beforeInsert;

  bool _beforeInsert<T extends Model>(T model) {
    (model as ChatMessageModel).createdAt = DateTime.now();
    model.updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeUpdate => _beforeUpdate;

  bool _beforeUpdate<T extends Model>(T model) {
    (model as ChatMessageModel).updatedAt = DateTime.now();
    return true;
  }

  void whereContains(String value) {
    where('CONTENT', '%$value%', operator: DatabaseWhereOperator.like);
  }
}
