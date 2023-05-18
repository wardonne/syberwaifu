import 'package:sqflite_common/sqlite_api.dart';

class DatabaseExecuteService {
  Transaction? transaction;

  beginTransaction(Transaction txn) => transaction = txn;

  endTransaction() => transaction = null;
}
