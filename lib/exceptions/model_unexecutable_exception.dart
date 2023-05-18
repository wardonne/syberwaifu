import 'package:flutter/material.dart';
import 'package:syberwaifu/models/model.dart';

class ModelUnexecutableException<T extends Model> extends ErrorDescription {
  ModelUnexecutableException(T model) : super('$T is a query instance');
}
