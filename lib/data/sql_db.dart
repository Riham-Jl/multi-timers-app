import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timers/model/timer_model.dart';

class TimerDatabase {
  static final TimerDatabase instance = TimerDatabase._init();
  static Database? _database;

  TimerDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('timers.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE timers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        label TEXT,
        duration INTEGER
      )
    ''');
  }

  Future<int> createTimer(TimerModel timer) async {
    final db = await instance.database;
    return await db.insert('timers', timer.toMap());
  }

  Future<List<TimerModel>> getTimers() async {
    final db = await instance.database;
    final maps = await db.query('timers');
    return maps.map((map) => TimerModel.fromMap(map)).toList();
  }



  Future<int> updateTimer(TimerModel timer) async {
    final db = await instance.database;
    return await db.update(
      'timers',
      timer.toMap(),
      where: 'id = ?',
      whereArgs: [timer.id],
    );
  }


  Future<int> deleteTimer(int id) async {
    final db = await instance.database;
    return await db.delete('timers', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}
