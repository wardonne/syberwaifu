import 'package:syberwaifu/exceptions/model_unexecutable_exception.dart';
import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/functions/time_util.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:uuid/uuid.dart';

class AvatarModel extends Model {
  String? _uuid;
  String? uri;
  DateTime? createdAt;

  String get uuid => _uuid ?? '';

  @override
  String get primaryKey => 'UUID';

  @override
  String? get primaryValue =>
      isQuery ? throw ModelUnexecutableException(this) : _uuid!;

  @override
  String get tableName => 'AVATARS';

  AvatarModel({required this.uri})
      : _uuid = const Uuid().v4(),
        super();

  AvatarModel.query() : super.query();

  AvatarModel.fromJSON(Map<String, Object?> json)
      : _uuid = Arr.get<String>(json, 'UUID'),
        uri = Arr.get<String>(json, 'URI'),
        createdAt = Arr.getCast<int, DateTime>(
            json, 'CREATED_AT', TimeUtil.fromTimestamp),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() {
    return {
      'UUID': _uuid,
      'URI': uri,
      'CREATED_AT': TimeUtil.timestamp(createdAt),
    };
  }

  Future<int> get chatCount async {
    final query = ChatModel.query();
    query.where('AVATAR_ID', uuid);
    return query.count();
  }

  @override
  bool Function<T extends Model>(T model)? get beforeInsert => _beforeInsert;

  bool _beforeInsert<T extends Model>(T model) {
    (model as AvatarModel).createdAt = DateTime.now();
    return true;
  }
}
