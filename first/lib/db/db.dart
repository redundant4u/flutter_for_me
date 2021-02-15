import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static const databaseName = "12.db";
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
        await database.execute("CREATE TABLE users        (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, male INTEGER, female INTEGER, year TEXT, month TEXT, day TEXT)");
      }
    );
  }
}