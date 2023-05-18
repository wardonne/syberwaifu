import 'package:flutter/material.dart';

class ModelCreatedFailureException extends ErrorDescription {
  final String tableName;
  final Map<String, Object?> values;

  ModelCreatedFailureException({required this.tableName, required this.values})
      : super('Insert into table `$tableName` failed with values: $values');
}
