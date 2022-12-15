import 'package:sqflite/sqflite.dart';

class AlarmHelper {
  late Database _database;

  Future<Database> get database async {
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "$dir alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {},
    );
    return database;
  }
}
