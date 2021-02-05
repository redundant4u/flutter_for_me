import 'package:sqflite/sqflite.dart';

import './db.dart';
import '../models/Left.dart';
import '../models/Right.dart';

// left
Future<List<double>> getLeftEQData() async {
  final Database _database = await DB.instance.database;
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
  final Database _database = await DB.instance.database;
  final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";
  final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM left_eq WHERE id = 1');

  Left left = Left(id: 1, name: '', dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);

  if( _hasData.isEmpty ) {
    print('eq insert');
    await _database.insert('left_eq', left.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  else {
    print('eq update');
    await _database.update('left_eq', left.toMap(), where: 'id = ?', whereArgs: [1], conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
// left end

// right
Future<List<double>> getRightEQData() async {
  final Database _database = await DB.instance.database;
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
  final Database _database = await DB.instance.database;
  final String date = "${now.year}년 ${now.month}월 ${now.day}일 ${now.hour}:${now.minute}";
  final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM right_eq WHERE id = 1');

  Right right = Right(id: 1, name: '', dB1: data[0], dB2: data[1], dB3: data[2], dB4: data[3], dB5: data[4], dB6: data[5], dB7: data[6], date: date);

  if( _hasData.isEmpty ) {
    print('eq insert');
    await _database.insert('right_eq', right.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  else {
    print('eq update');
    await _database.update('right_eq', right.toMap(), where: 'id = ?', whereArgs: [1], conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
// right end