import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Left.dart';
import '../models/Right.dart';
import '../models/Users.dart';

class DB {
  DB._();

  static const databaseName = "10.db";
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
        await database.execute("CREATE TABLE left_graphs  (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, dB1 REAL, dB2 REAL, dB3 REAL, dB4 REAL, dB5 REAL, dB6 REAL, dB7 REAL, date TEXT)");
        await database.execute("CREATE TABLE right_graphs (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, dB1 REAL, dB2 REAL, dB3 REAL, dB4 REAL, dB5 REAL, dB6 REAL, dB7 REAL, date TEXT)");
        await database.execute("CREATE TABLE left_eq      (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, dB1 REAL, dB2 REAL, dB3 REAL, dB4 REAL, dB5 REAL, dB6 REAL, dB7 REAL, date TEXT)");
        await database.execute("CREATE TABLE right_eq     (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, dB1 REAL, dB2 REAL, dB3 REAL, dB4 REAL, dB5 REAL, dB6 REAL, dB7 REAL, date TEXT)");
        await database.execute("CREATE TABLE users        (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, gender INTEGER NOT NULL, birth TEXT NOT NULL");
      }
    );
  }

  // left start
  Future<void> insertLeftGraphData(List<double> data) async {
    final DateTime now = DateTime.now();
    final Database _database = await database;
    final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";

    Left left = Left(dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);
    await _database.insert( 'left_graphs', left.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }

  Future<List<Left>> getLeftGrpahWholeData() async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('left_graphs');
    
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

  Future<List<double>> getLeftGraphData(int id) async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('left_graphs', where: 'id = ?', whereArgs: [id]);
    final List<double> res = [
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

  Future<void> deleteLeftGraphData(int id) async {
    final Database _database = await database;
    await _database.delete('left_graphs', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Left>> getEQTEST() async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('left_eq', orderBy: 'id DESC');

    return List.generate(maps.length, (i) {
      return Left(
        id: maps[i]['id'],
        date: maps[i]['date']
      );
    });
  }

  Future<List<double>> getLeftEQData() async {
    final Database _database = await database;
    final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM left_eq WHERE id = 1');

    if( _hasData.isEmpty ) {
      print('empty!');
      return [ 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ];
    }

    else {
      print('not empty!');
      return [
        _hasData[0]['dB1'],
        _hasData[0]['dB2'],
        _hasData[0]['dB3'],
        _hasData[0]['dB4'],
        _hasData[0]['dB5'],
        _hasData[0]['dB6'],
        _hasData[0]['dB7'],
      ];
    }
  }

  Future<void> upsertLeftEQData(List<double> data) async {
    final DateTime now = DateTime.now();
    final Database _database = await database;
    final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";
    final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM left_eq WHERE id = 1');

    Left left = Left(id: 1, name: '', dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);

    if( _hasData.isEmpty ) {
      print('insert');
      await _database.insert('left_eq', left.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    else {
      print('update');
      await _database.update('left_eq', left.toMap(), where: 'id = ?', whereArgs: [1], conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
  // left end

  // right start
  Future<void> insertRightGraphData(List<double> data) async {
    final DateTime now = DateTime.now();
    final Database _database = await database;
    final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";
    print(date);

    Right right = Right(dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);
    await _database.insert( 'right_graphs', right.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }

  Future<List<double>> getRightGraphData(int id) async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('right_graphs', where: 'id = ?', whereArgs: [id]);
    final List<double> res = [
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

  Future<List<double>> getRightEQData() async {
    final Database _database = await database;
    final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM right_eq WHERE id = 1');

    if( _hasData.isEmpty ) {
      print('empty!');
      return [ 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ];
    }

    else {
      print('not empty!');
      return [
        _hasData[0]['dB1'],
        _hasData[0]['dB2'],
        _hasData[0]['dB3'],
        _hasData[0]['dB4'],
        _hasData[0]['dB5'],
        _hasData[0]['dB6'],
        _hasData[0]['dB7'],
      ];
    }
  }

  Future<void> upsertRightEQData(List<double> data) async {
    final DateTime now = DateTime.now();
    final Database _database = await database;
    final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";
    final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM right_eq WHERE id = 1');

    Right right = Right(id: 1, name: '', dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);

    if( _hasData.isEmpty ) {
      print('insert');
      await _database.insert('right_eq', right.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    else {
      print('update');
      await _database.update('right_eq', right.toMap(), where: 'id = ?', whereArgs: [1], conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
  // right end

  // For ThirdPage Futurebuilder
  Future<List<Left>> getGraphDate() async {
    final Database _database = await database;
    final List<Map<String, dynamic>> maps = await _database.query('left_graphs', orderBy: 'id DESC');

    return List.generate(maps.length, (i) {
      return Left(
        id: maps[i]['id'],
        date: maps[i]['date']
      );
    });
  }

  // privacy information
  Future<void> insertPrivacyInformation(Users data) async {
    final Database _database = await database;

    Users users = Users(name: data.name, gender: data.gender, birth: data.birth);
    await _database.insert( 'users', users.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }
}