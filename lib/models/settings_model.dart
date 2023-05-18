import 'package:syberwaifu/enums/database_where_operator.dart';
import 'package:syberwaifu/models/model.dart';

class SettingsModel extends Model {
  String? attribute;
  String? value;

  @override
  String get tableName => 'SETTINGS';

  @override
  String get primaryKey => 'ATTRIBUTE';

  @override
  String get primaryValue => attribute!;

  SettingsModel({required this.attribute, required this.value});

  SettingsModel.query() : super.query();

  @override
  SettingsModel.fromJSON(Map<String, Object?> json)
      : attribute = json['ATTRIBUTE'] as String,
        value = json['VALUE'] as String,
        super.fromJSON(json);

  @override
  Map<String, String?> toJSON() => {
        "ATTRIBUTE": attribute,
        "VALUE": value,
      };

  whereAttribute(String value) {
    where('ATTRIBUTE', value);
  }

  whereModule(String prefix) {
    where('ATTRIBUTE', '$prefix%', operator: DatabaseWhereOperator.like);
  }
}
