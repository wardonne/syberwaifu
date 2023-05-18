import 'package:syberwaifu/exceptions/model_unexecutable_exception.dart';
import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/functions/time_util.dart';
import 'package:syberwaifu/models/chat/quote_clip_message_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:uuid/uuid.dart';

class QuoteClipModel extends Model {
  String? _uuid;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? get uuid => _uuid;

  @override
  String get tableName => 'QUOTE_CLIPS';

  @override
  String get primaryKey => 'UUID';

  @override
  String get primaryValue =>
      isQuery ? throw ModelUnexecutableException(this) : uuid!;

  QuoteClipModel()
      : _uuid = const Uuid().v4(),
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  QuoteClipModel.query() : super.query();

  QuoteClipModel.fromJSON(Map<String, Object?> json)
      : _uuid = Arr.get<String>(json, 'UUID'),
        createdAt = Arr.getCast<int, DateTime>(
            json, 'CREATED_AT', TimeUtil.fromTimestamp),
        updatedAt = Arr.getCast(json, 'UPDATED_AT', TimeUtil.fromTimestamp),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() => {
        'UUID': _uuid,
        'CREATED_AT': TimeUtil.timestamp(createdAt),
        'UPDATED_AT': TimeUtil.timestamp(updatedAt),
      };

  Future<List<QuoteClipMessageModel>> get messages async {
    final queryBuilder = QuoteClipMessageModel.query();
    queryBuilder.whereQuoteId(uuid!);
    return queryBuilder.findAll<QuoteClipMessageModel>();
  }

  @override
  bool Function<T extends Model>(T model)? get beforeInsert => _beforeInsert;

  bool _beforeInsert<T extends Model>(T model) {
    (model as QuoteClipModel).createdAt = DateTime.now();
    model.updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeUpdate => _beforeUpdate;

  bool _beforeUpdate<T extends Model>(T model) {
    (model as QuoteClipModel).updatedAt = DateTime.now();
    return true;
  }
}
