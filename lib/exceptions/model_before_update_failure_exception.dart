import 'package:flutter/material.dart';
import 'package:syberwaifu/models/model.dart';

class ModelBeforeUpdateFailureException<T extends Model>
    extends ErrorDescription {
  ModelBeforeUpdateFailureException(T model)
      : super('$T execute before update failed');
}
