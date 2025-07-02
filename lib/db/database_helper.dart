import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Singleton helper SQLite
class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cafe_menu.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Buat tabel
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE menu (
        id TEXT PRIMARY KEY,
        name TEXT,
        category TEXT,
        price REAL,
        image TEXT
      )
    ''');
  }

  //─────────────────────────────── CRUD
  Future<void> insertMenu(Map<String, dynamic> data) async {
    final db = await instance.database;
    await db.insert('menu', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllMenu() async {
    final db = await instance.database;
    return await db.query('menu');
  }

  Future<void> deleteAllMenu() async {
    final db = await instance.database;
    await db.delete('menu');
  }
}
