import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zendy/helpers/print_log.dart';

class LocalDataService {
  static Database? _database;
  final String tableName;

  LocalDataService(this.tableName);

  Future<Database> _openDatabase() async {
    if (_database != null) {
      return _database!;
    }

    String dbPath = join('local_data.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
        ''');
      },
    );

    return _database!;
  }

  Stream<List<dynamic>> fetchData(userId) async* {
    printLog('fetchData-userId', userId);
    final db = await _openDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    yield maps;
  }

  Future<dynamic> create(dynamic data) async {
    final db = await _openDatabase();
    var enData = jsonEncode(data);
    await db.insert(tableName, {'data': enData});
    return data;
  }

  Future<dynamic> update(dynamic data) async {
    final db = await _openDatabase();
    await db.update(
      tableName,
      {'data': data},
      where: 'data = ?',
      whereArgs: [data],
    );
    return data;
  }

  Future<dynamic> delete(dynamic id) async {
    final db = await _openDatabase();

    int rowsAffected = await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return rowsAffected;
  }
}
