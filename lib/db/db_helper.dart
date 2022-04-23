import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static const int _version = 1;
  static const String _tableName = 'tasks';
  static Database? _db;

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, color INTEGER, isCompleted INTEGER)');
        });
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  static Future<int> insert(Task task) async {
    debugPrint('inserting task');
    try {
      return await _db!.insert(_tableName, task.toJson());
    } catch (e) {
      return 9000;
    }
  }

  static Future<int> delete(int id) async {
    debugPrint('deleting task');
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> update(int id) async {
    debugPrint('updating task');
    return await _db!
        .rawUpdate('UPDATE $_tableName SET isCompleted = 1 WHERE id = $id');
  }

  static Future<int> deleteall() async {
    debugPrint('deleteAll tasks');
    return await _db!.delete(_tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }
}
