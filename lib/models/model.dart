import 'dart:async';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:syberwaifu/enums/database_where_operator.dart';
import 'package:syberwaifu/exceptions/model_before_insert_failure_exception.dart';
import 'package:syberwaifu/exceptions/model_create_failure_exception.dart';
import 'package:syberwaifu/exceptions/model_not_found_exception.dart';
import 'package:syberwaifu/exceptions/model_unexecutable_exception.dart';
import 'package:syberwaifu/factories/model_factory.dart';
import 'package:syberwaifu/global_vars/database.dart';

class Model extends Object {
  static final Database database = db;

  String get tableName => '';

  String get primaryKey => '';

  String? get primaryValue => null;

  bool _isQuery = false;

  bool get isQuery => _isQuery;

  bool _isNew = true;

  bool get isNew => _isNew;

  bool Function<T extends Model>(T model)? get beforeInsert => null;

  void Function<T extends Model>(T model)? get afterInsert => null;

  bool Function<T extends Model>(T model)? get beforeUpdate => null;

  void Function<T extends Model>(T model)? get afterUpdate => null;

  Model();

  Model.query()
      : _isQuery = true,
        _isNew = false;

  Model.fromJSON(Map<String, Object?> json) : _isNew = false;

  Map<String, Object?> toJSON() => {};

  bool distinct = false;

  List<String> select = [];

  String _condition = '';

  String? get condition {
    final whereStr = _condition.replaceFirst(RegExp('AND|OR'), '');
    if (whereStr.trim().isEmpty) {
      return null;
    }
    return whereStr;
  }

  List<Object?> whereArgs = [];

  where(
    String column,
    Object value, {
    DatabaseWhereOperator operator = DatabaseWhereOperator.eq,
  }) {
    _condition += ' AND $column ${operator.symbal} ?';
    whereArgs.add(value);
  }

  orWhere(
    String column,
    Object value, {
    DatabaseWhereOperator operator = DatabaseWhereOperator.eq,
  }) {
    _condition += ' OR $column ${operator.symbal} ?';
    whereArgs.add(value);
  }

  whereRaw(String sql) {
    _condition += ' AND ($sql)';
  }

  orWhereRaw(String sql) {
    _condition += ' OR ($sql)';
  }

  whereCallback(Model Function(Model model) callback) {
    final query = callback(Model.query());
    final extraCondition = query._condition;
    _condition += ' AND ($extraCondition)';
  }

  orWhereCallback(Model Function(Model model) callback) {
    final query = callback(Model.query());
    _condition += ' OR (${query._condition})';
  }

  whereIn(String column, List<Object> values) {
    _condition +=
        ' AND $column IN (${List.filled(values.length, '?').join(' ')})';
    whereArgs.addAll(values);
  }

  orWhereIn(String column, List<Object> values) {
    _condition +=
        ' OR $column IN (${List.filled(values.length, '?').join(' ')})';
    whereArgs.addAll(values);
  }

  whereNotIn(String column, List<Object> values) {
    _condition +=
        ' AND $column NOT IN (${List.filled(values.length, '?').join(' ')})';
    whereArgs.addAll(values);
  }

  orWhereNotIn(String column, List<Object> values) {
    _condition +=
        ' OR $column NOT IN (${List.filled(values.length, '?').join(' ')})';
    whereArgs.addAll(values);
  }

  whereBetween(
    String column,
    Object start,
    Object end,
  ) {
    _condition += ' AND $column BETWEEN (?, ?)';
    whereArgs.addAll([start, end]);
  }

  orWhereBetween(
    String column,
    Object start,
    Object end,
  ) {
    _condition += ' OR $column BETWEEN (?, ?)';
    whereArgs.addAll([start, end]);
  }

  whereNotBetween(
    String column,
    Object start,
    Object end,
  ) {
    _condition += ' AND $column NOT BETWEEN (?, ?)';
    whereArgs.addAll([start, end]);
  }

  orWhereNotBetween(
    String column,
    Object start,
    Object end,
  ) {
    _condition += ' AND $column NOT BETWEEN (?, ?)';
    whereArgs.addAll([start, end]);
  }

  String? orderBy;

  String? groupBy;

  String? having;

  int? limit;

  int? offset;

  final Map<String, Object?> relations = {};

  Object? clearRelation(String key) => relations.remove(key);

  static Future<T> transaction<T>(
      Future<T> Function(Transaction txn) action) async {
    return await database.transaction<T>(action);
  }

  Future<void> execute(String sql, {Transaction? txn}) async {
    if (txn != null) {
      return await txn.execute(sql);
    } else {
      return await database.execute(sql);
    }
  }

  Future<List<Map<String, Object?>>> query([Transaction? txn]) async {
    return txn == null
        ? await database.query(
            tableName,
            distinct: distinct,
            columns: select,
            where: condition,
            whereArgs: whereArgs,
            orderBy: orderBy,
            groupBy: groupBy,
            having: having,
            limit: limit,
            offset: offset,
          )
        : await txn.query(
            tableName,
            distinct: distinct,
            columns: select,
            where: condition,
            whereArgs: whereArgs,
            orderBy: orderBy,
            groupBy: groupBy,
            having: having,
            limit: limit,
            offset: offset,
          );
  }

  Future<List<T>> findAll<T extends Model>([Transaction? txn]) async {
    final rows = await query(txn);
    return rows.map((row) => model<T>(row)).toList();
  }

  Future<T?> find<T extends Model>({Object? pk, Transaction? txn}) async {
    limit = 1;
    if (pk != null) {
      where(primaryKey, pk);
    }
    final rows = await findAll<T>(txn);
    if (rows.isNotEmpty) {
      return rows.first;
    }
    return null;
  }

  Future<T> findOrFail<T extends Model>({Object? pk, Transaction? txn}) async {
    limit = 1;
    if (pk != null) {
      where(primaryKey, pk);
    }
    final rows = await findAll<T>(txn);
    if (rows.isEmpty) {
      throw ModelNotFoundException(id: pk, modelName: T.toString());
    }
    return rows.first;
  }

  Future<int> count([Transaction? txn]) async {
    select = ['COUNT(*) as aggregate'];
    final rows = await query(txn);
    if (rows.isEmpty) {
      return 0;
    }
    return rows.first['aggregate'] as int;
  }

  Future<bool> exists<T extends Model>([Transaction? txn]) async {
    return (await count(txn)) > 0;
  }

  Future<T> create<T extends Model>([Transaction? txn]) async {
    if (_isQuery) {
      throw ModelUnexecutableException(this as T);
    }
    if ((this as T).beforeInsert != null && !(this as T).beforeInsert!(this)) {
      throw ModelBeforeInsertFailureException(this as T);
    }
    int affectedCount = 0;
    if (txn != null) {
      affectedCount = await txn.insert(tableName, toJSON());
    } else {
      affectedCount = await database.insert(tableName, toJSON());
    }
    if (affectedCount > 0) {
      if ((this as T).afterInsert != null) {
        (this as T).afterInsert!(this);
      }
      return this as T;
    }
    throw ModelCreatedFailureException(tableName: tableName, values: toJSON());
  }

  Future<T> update<T extends Model>([Transaction? txn]) async {
    if (_isQuery) {
      throw ModelUnexecutableException(this as T);
    }
    if ((this as T).beforeUpdate != null && !(this as T).beforeUpdate!(this)) {}
    where(primaryKey, primaryValue!);
    if (txn != null) {
      await txn.update(
        tableName,
        toJSON(),
        where: condition,
        whereArgs: whereArgs,
      );
    } else {
      await database.update(
        tableName,
        toJSON(),
        where: condition,
        whereArgs: whereArgs,
      );
    }
    return this as T;
  }

  Future<void> delete<T extends Model>([Transaction? txn]) async {
    if (_isQuery) {
      if (txn != null) {
        await txn.delete(tableName, where: condition, whereArgs: whereArgs);
      } else {
        await database.delete(tableName,
            where: condition, whereArgs: whereArgs);
      }
    } else {
      where(primaryKey, primaryValue!);
      if (txn != null) {
        await txn.delete(tableName, where: condition, whereArgs: whereArgs);
      } else {
        await database.delete(tableName,
            where: condition, whereArgs: whereArgs);
      }
    }
  }
}
