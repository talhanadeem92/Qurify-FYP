import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'quran.db';
  static const _databaseVersion = 1;

  static const tableSurahMetadata = 'SurahMetadata';
  static const tableVerse = 'Verse';

  // Database instance
  static Database? _database;

  // Singleton pattern for DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    // Set the path for the database
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create tables when the database is created
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableSurahMetadata (
        id INTEGER PRIMARY KEY,
        name TEXT,
        transliteration TEXT,
        translation TEXT,
        type TEXT,
        total_verses INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableVerse (
        id INTEGER PRIMARY KEY,
        surah_id INTEGER,
        verse_number INTEGER,
        arabic_text TEXT,
        translation TEXT,
        FOREIGN KEY (surah_id) REFERENCES $tableSurahMetadata (id)
      )
    ''');
  }

  // Insert Surah Metadata
  Future<void> insertSurahMetadata(List<Map<String, dynamic>> surahList) async {
    final db = await database;
    for (var surah in surahList) {
      await db.insert(tableSurahMetadata, surah, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // Insert Verses
  Future<void> insertVerses(Map<String, dynamic> versesMap) async {
    final db = await database;

    versesMap.forEach((surahId, verses) async {
      for (var verse in verses) {
        Map<String, dynamic> verseData = {
          'surah_id': int.parse(surahId),
          'verse_number': verse['verse'],
          'arabic_text': '',  // Add Arabic text if available
          'translation': verse['text'],
        };

        await db.insert(tableVerse, verseData, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  // Query Surah Metadata
  Future<List<Map<String, dynamic>>> getSurahMetadata() async {
    final db = await database;
    return await db.query(tableSurahMetadata);
  }

  // Query Verses by Surah ID
  Future<List<Map<String, dynamic>>> getVersesBySurahId(int surahId) async {
    final db = await database;
    return await db.query(tableVerse, where: 'surah_id = ?', whereArgs: [surahId]);
  }
}
