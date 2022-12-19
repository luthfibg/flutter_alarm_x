import 'package:nfp110/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

const String tableAlarm = 'alr_alarm';
const String columnId = 'alr_id';
const String columnTitle = 'alr_title';
const String columnDateTime = 'alr_dateTime';
const String columnPending = 'alr_isPending';
const String columnColorIndex = 'alr_gradientColorIndex';

class AlarmHelper {
  static late Database _database;
  static late AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

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
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm (
            $columnId integer primary key autoincrement,
            $columnTitle text not null,
            $columnDateTime text not null,
            $columnPending integer,
            $columnColorIndex integer,
          )
        ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    // ignore: avoid_print
    print('result: $result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });
    return _alarms;
  }

  Future<int> delete(int? id) async {
    var db = await database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
