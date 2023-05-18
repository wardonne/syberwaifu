import 'package:flutter/material.dart';

class ModelNotFoundException extends ErrorDescription {
  ModelNotFoundException({
    Object? id,
    String? modelName,
  }) : super(
            'Not found in model${modelName == null ? '' : '($modelName)'} with given id${id == null ? '' : '($id)'}');
}
