import 'dart:io';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (Platform.isAndroid || Platform.isIOS) {
      String path = join(await getDatabasesPath(), 'quran.db');
      return await openDatabase(path, version: 1, onCreate: _createDB);
    } else {
      databaseFactory = databaseFactoryFfiWeb; // ✅ Use for Web
      return await databaseFactory.openDatabase('quran.db');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE surah (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        transliteration TEXT NOT NULL,
        translation TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE verse (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah_id INTEGER NOT NULL,
        text TEXT NOT NULL,
        FOREIGN KEY (surah_id) REFERENCES surah (id)
      )
    ''');
  }
}
