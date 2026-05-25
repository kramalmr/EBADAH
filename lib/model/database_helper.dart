import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('doa.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE doa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category TEXT NOT NULL,
    title TEXT NOT NULL,
    arabic TEXT NOT NULL,
    latin TEXT NOT NULL,
    translation TEXT NOT NULL
  )
''');
    await db.execute('''
    CREATE TABLE location (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      city TEXT NOT NULL,
      country TEXT NOT NULL
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> resetDatabase() async {
    final db = await instance.database;
    await db.close();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'doa.db');
    await deleteDatabase(path); // hapus file database lama
    _database = await _initDB('doa.db'); // buat ulang
  }
}
