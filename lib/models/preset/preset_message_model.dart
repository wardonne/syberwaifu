import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/functions/time_util.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:uuid/uuid.dart';

class PresetMessageModel extends Model {
  String? _uuid;
  String? presetId;
  String? role;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  @override
  String get tableName => 'PRESET_MESSAGES';

  @override
  String get primaryKey => 'UUID';

  @override
  String? get primaryValue => _uuid;

  String? get uuid => _uuid;

  PresetMessageModel({
    required this.presetId,
    required this.role,
    required this.content,
  }) : _uuid = const Uuid().v4();

  PresetMessageModel.query() : super.query();

  PresetMessageModel.fromJSON(Map<String, Object?> json)
      : _uuid = Arr.get<String>(json, 'UUID'),
        presetId = Arr.get<String>(json, 'PRESET_ID'),
        role = Arr.get<String>(json, 'ROLE'),
        content = Arr.get<String>(json, 'CONTENT'),
        createdAt = Arr.getCast<int, DateTime>(
            json, 'CREATED_AT', TimeUtil.fromTimestamp),
        updatedAt = Arr.getCast<int, DateTime>(
            json, 'UPDATED_AT', TimeUtil.fromTimestamp),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() => {
        'UUID': _uuid,
        'PRESET_ID': presetId,
        'ROLE': role,
        'CONTENT': content,
        'CREATED_AT': TimeUtil.timestamp(createdAt),
        'UPDATED_AT': TimeUtil.timestamp(updatedAt),
      };

  Future<PresetModel> get preset async {
    return await PresetModel.query().findOrFail<PresetModel>(pk: presetId);
  }

  wherePresetId(String value) => where('PRESET_ID', value);

  bool _beforeInsert<T extends Model>(T model) {
    (model as PresetMessageModel).createdAt = DateTime.now();
    model.updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeInsert => _beforeInsert;

  bool _beforeUpdate<T extends Model>(T model) {
    (model as PresetMessageModel).updatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeUpdate => _beforeUpdate;
}
