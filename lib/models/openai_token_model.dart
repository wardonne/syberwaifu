import 'package:syberwaifu/exceptions/model_unexecutable_exception.dart';
import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/functions/time_util.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:uuid/uuid.dart';

class OpenAITokenModel extends Model {
  String? _uuid;
  String? name;
  String? token;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  String get uuid => _uuid!;

  @override
  String get primaryKey => 'UUID';

  @override
  String get primaryValue =>
      isQuery ? throw ModelUnexecutableException(this) : _uuid!;

  @override
  String get tableName => 'OPENAI_TOKENS';

  OpenAITokenModel({
    required this.name,
    required this.token,
    required this.status,
  }) : _uuid = const Uuid().v4();

  OpenAITokenModel.query() : super.query();

  OpenAITokenModel.fromJSON(Map<String, Object?> json)
      : _uuid = Arr.get<String>(json, 'UUID'),
        name = Arr.get<String>(json, 'NAME'),
        token = Arr.get<String>(json, 'TOKEN'),
        status = Arr.get<int>(json, 'STATUS'),
        createdAt = Arr.getCast<int, DateTime>(
            json, 'CREATED_AT', TimeUtil.fromTimestamp),
        updatedAt = Arr.getCast<int, DateTime>(
            json, 'UPDATED_AT', TimeUtil.fromTimestamp),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() => {
        'UUID': _uuid,
        'NAME': name,
        'TOKEN': token,
        'STATUS': status,
        'CREATED_AT': TimeUtil.timestamp(createdAt),
        'UPDATED_AT': TimeUtil.timestamp(updatedAt),
      };

  bool _beforeInsert<T extends Model>(T model) {
    (model as OpenAITokenModel).createdAt = DateTime.now();
    model.updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeInsert => _beforeInsert;

  bool _beforeUpdate<T extends Model>(T model) {
    (model as OpenAITokenModel).updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeUpdate => _beforeUpdate;

  Future<List<ChatModel>> get chats async {
    final query = ChatModel.query();
    query.whereOpenAITokenId(uuid);
    query.orderBy = 'LAST_CHATED_AT DESC';
    return await query.findAll<ChatModel>();
  }

  Future<int> get chatCount async {
    final query = ChatModel.query();
    query.whereOpenAITokenId(uuid);
    return await query.count();
  }
}
