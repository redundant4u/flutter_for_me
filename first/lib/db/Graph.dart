import 'package:sqflite/sqflite.dart';

import './db.dart';
import '../models/Left.dart';
import '../models/Right.dart';

// left
Future<void> insertLeftGraphData(List<double> data) async {
  final DateTime now = DateTime.now();
  final Database _database = await DB.instance.database;
  final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";

  Left left = Left(dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);
  await _database.insert( 'left_graphs', left.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
}

Future<List<Left>> getLeftGrpahWholeData() async {
  final Database _database = await DB.instance.database;
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
  final Database _database = await DB.instance.database;
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
  final Database _database = await DB.instance.database;
  await _database.delete('left_graphs', where: 'id = ?', whereArgs: [id]);
}
// left end

// right
Future<void> insertRightGraphData(List<double> data) async {
    final DateTime now = DateTime.now();
    final Database _database = await DB.instance.database;
    final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";
    print(date);

    Right right = Right(dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);
    await _database.insert( 'right_graphs', right.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
}

Future<List<double>> getRightGraphData(int id) async {
  final Database _database = await DB.instance.database;
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
// right end

// For ThirdPage Futurebuilder
Future<List<Left>> getGraphDate() async {
  final Database _database = await DB.instance.database;
  final List<Map<String, dynamic>> maps = await _database.query('left_graphs', orderBy: 'id DESC');

  return List.generate(maps.length, (i) {
    return Left(
      id: maps[i]['id'],
      date: maps[i]['date']
    );
  });
}