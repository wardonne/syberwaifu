import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DatabaseVM extends ChangeNotifier {
  final Database database;

  DatabaseVM(this.database);
}
