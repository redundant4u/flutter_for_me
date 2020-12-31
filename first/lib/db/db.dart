import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Left.dart';
import '../models/Right.dart';

class DB {
  DB._();

  static const dbName = "1.db";
  static final DB instance = DB._();
  static Database _db;

  Future<Database> get db async {
    if( _db == null ) return await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    return await openDatabase(
      join( await getDatabasesPath(), dbName ),
      version: 1,
      onCreate: ( Database db, int version ) async {
        await db.execute("CREATE TABLE left (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name STRING)");
        await db.execute("CREATE TABLE right (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name STRING)");
      }
    );
  }

  // left
  Future<void> insertLeftName(String name) async {
    final Database database = await db;

    Left left = Left( name: name );

    await database.insert( 'left', left.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }

  Future<List<Left>> getLeftName() async {
    final Database database = await db;
    final List<Map<String, dynamic>> maps = await database.query( 'left', orderBy: 'id DESC' );

    return List.generate(maps.length, (i) {
        return Left(
          id: maps[i]['id'],
          name: maps[i]['name']
        );
    });
  }

  Future<void> deleteLeftName(int id) async {
    final Database database = await db;
    await database.delete( 'left', where: 'id = ?', whereArgs: [id] );
  }

  // right
  Future<void> insertRightName(String name) async {
    final Database database = await db;

    Right right = Right( name: name );

    await database.insert( 'right', right.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }

  Future<List<Right>> getRightName() async {
    final Database database = await db;
    final List<Map<String, dynamic>> maps = await database.query('right');
    return List.generate(maps.length, (i) {
        return Right(
          id: maps[i]['id'],
          name: maps[i]['name']
        );
    });
  }

  Future<void> deleteRightName(int id) async {
    final Database database = await db;
    await database.delete( 'right', where: 'id = ?', whereArgs: [id] );
  }
}