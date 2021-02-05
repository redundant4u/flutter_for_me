import 'package:sqflite/sqflite.dart';

import './db.dart';
import '../models/User.dart';

Future<void> upsertPrivacyInformation(User data) async {
  final Database _database = await DB.instance.database;
  final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM users WHERE id = 1');

  User user = User(id: 1, name: data.name, male: data.male, female: data.female, birth: data.birth);

  if( _hasData.isEmpty ) {
    print('user insert');
    await _database.insert( 'users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );  
  }

  else {
    print('user update');
    await _database.update( 'users', user.toMap(), where: 'id = ? ', whereArgs: [1], conflictAlgorithm: ConflictAlgorithm.replace );
  }
}

Future<User> getPrivacyInformationData() async {
  final Database _database = await DB.instance.database;
  final List<Map<String, dynamic>> _hasData = await _database.rawQuery('SELECT * FROM users WHERE id = 1');
  User _user = User();

  if( _hasData.isNotEmpty ) {
    _user = User(
      id: _hasData[0]['id'],
      name: _hasData[0]['name'],
      birth: _hasData[0]['birth'],
      male: _hasData[0]['male'],
      female: _hasData[0]['female']
    );
  }

  return _user;
  }

// for test!!
Future<List<User>> getUserList() async {
  final Database _database = await DB.instance.database;
  final List<Map<String, dynamic>> maps = await _database.query('users');

  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      name: maps[i]['name'],
      birth: maps[i]['birth'],
      male: maps[i]['male'],
      female: maps[i]['female']
    );
  });
}

Future<void> deleteUser() async {
  final Database _database = await DB.instance.database;
  await _database.delete('users', where: "id = ?", whereArgs: [1]);
}