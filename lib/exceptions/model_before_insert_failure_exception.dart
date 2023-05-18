import 'package:flutter/material.dart';
import 'package:syberwaifu/models/model.dart';

class ModelBeforeInsertFailureException<T extends Model>
    extends ErrorDescription {
  ModelBeforeInsertFailureException(T model)
      : super('$T execute before insert failed');
}
