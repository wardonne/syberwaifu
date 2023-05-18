import 'package:syberwaifu/constants/preset.dart';
import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/functions/time_util.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/preset/preset_message_model.dart';
import 'package:uuid/uuid.dart';

class PresetModel extends Model {
  String? _uuid;
  String? name;
  String? nickname;
  int? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  @override
  String get tableName => 'PRESETS';

  @override
  String get primaryKey => 'UUID';

  @override
  String? get primaryValue => uuid;

  String? get uuid => _uuid;

  PresetModel({
    required this.name,
    required this.nickname,
    required this.isDefault,
  })  : _uuid = const Uuid().v4(),
        super();

  PresetModel.query() : super.query();

  PresetModel.fromJSON(Map<String, Object?> json)
      : _uuid = Arr.get<String>(json, 'UUID'),
        name = Arr.get<String>(json, 'NAME'),
        nickname = Arr.get<String>(json, 'NICKNAME'),
        isDefault = Arr.get<int>(json, 'IS_DEFAULT'),
        createdAt = Arr.getCast<int, DateTime>(
            json, 'CREATED_AT', TimeUtil.fromTimestamp),
        updatedAt = Arr.getCast<int, DateTime>(
            json, 'UPDATED_AT', TimeUtil.fromTimestamp),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() => {
        'UUID': uuid,
        'NAME': name,
        'NICKNAME': nickname,
        'IS_DEFAULT': isDefault,
        'CREATED_AT': TimeUtil.timestamp(createdAt),
        'UPDATED_AT': TimeUtil.timestamp(updatedAt),
      };

  Future<List<PresetMessageModel>> get messages async {
    final builder = PresetMessageModel.query()
      ..wherePresetId(uuid!)
      ..orderBy = 'CREATED_AT ASC';
    return await builder.findAll<PresetMessageModel>();
  }

  Future<List<ChatModel>> get chats async {
    final query = ChatModel.query();
    query.wherePresetId(uuid!);
    query.orderBy = 'LAST CHATED_AT DESC';
    return await query.findAll<ChatModel>();
  }

  Future<int> get chatCount async {
    final query = ChatModel.query();
    query.wherePresetId(uuid!);
    return await query.count();
  }

  whereIsDefault(int value) {
    where('IS_DEFAULT', value);
  }

  bool _beforeInsert<T extends Model>(T model) {
    (model as PresetModel).createdAt = DateTime.now();
    model.updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeInsert => _beforeInsert;

  bool _beforeUpdate<T extends Model>(T model) {
    (model as PresetModel).updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeUpdate => _beforeUpdate;

  bool checkIsDefault() =>
      (isDefault ?? PresetConstants.notDefault) == PresetConstants.isDefault;
}
