import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Left.dart';
import '../models/Right.dart';

class DB {
  DB._();

  static const databaseName = "5.db";
  static final DB instance = DB._();
  static Database _database;

  Future<Database> get database async {
    if( _database == null ) return await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(
      join( await getDatabasesPath(), databaseName ),
      version: 1,
      onCreate: ( Database database, int version ) async {
        await database.execute("CREATE TABLE left  (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, dB1 INTEGER, dB2 INTEGER, dB3 INTEGER, dB4 INTEGER, dB5 INTEGER, dB6 INTEGER, dB7 INTEGER, date TEXT)");
        await database.execute("CREATE TABLE right (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, dB1 INTEGER, dB2 INTEGER, dB3 INTEGER, dB4 INTEGER, dB5 INTEGER, dB6 INTEGER, dB7 INTEGER, date TEXT)");
      }
    );
  }

  // left start
  Future<void> insertLeftData(List<int> data) async {
    DateTime now = DateTime.now();

    final Database _database = await database;
    final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";

    Left left = Left(dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);
    await _database.insert( 'left', left.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }

  Future<List<Left>> getLeftWholeData() async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('left');
    
    return List.generate(maps.length, (i) {
      return Left(
        id: maps[i]['id'],
        dB1: maps[i]['dB1'],
        dB2: maps[i]['dB2'],
        dB3: maps[i]['dB3'],
        dB4: maps[i]['dB4'],
        dB5: maps[i]['dB5'],
        dB6: maps[i]['dB6'],
        dB7: maps[i]['dB7'],
        date: maps[i]['date']
      );
    });
  }

  Future<List<int>> getLeftData(int id) async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('left', where: 'id = ?', whereArgs: [id]);
    final List<int> res = [
      maps[0]['dB1'],
      maps[0]['dB2'],
      maps[0]['dB3'],
      maps[0]['dB4'],
      maps[0]['dB5'],
      maps[0]['dB6'],
      maps[0]['dB7']
    ];

    return res;
  }

  Future<void> deleteLeftData(int id) async {
    final Database _database = await database;
    await _database.delete('left', where: 'id = ?', whereArgs: [id]);
  }
  // left end

  // right start
  Future<void> insertRightData(List<int> data) async {
    DateTime now = DateTime.now();

    final Database _database = await database;
    final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";
    print(date);

    Right right = Right(dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);
    await _database.insert( 'right', right.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }

  Future<List<int>> getRightData(int id) async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('right', where: 'id = ?', whereArgs: [id]);
    final List<int> res = [
      maps[0]['dB1'],
      maps[0]['dB2'],
      maps[0]['dB3'],
      maps[0]['dB4'],
      maps[0]['dB5'],
      maps[0]['dB6'],
      maps[0]['dB7']
    ];

    return res;
  }
  // right end

  // For ThirdPage Futurebuilder
  Future<List<Left>> getDate() async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('left', orderBy: 'id DESC');

    return List.generate(maps.length, (i) {
      return Left(
        id: maps[i]['id'],
        date: maps[i]['date']
      );
    });
  }
}