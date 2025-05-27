import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/dday_event.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  DatabaseHelper._internal();

  static void resetInstance() {
    _instance = null;
    _database = null;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'dday_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dday_events(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        targetDate TEXT NOT NULL,
        type TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        color INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE dday_events ADD COLUMN color INTEGER NOT NULL DEFAULT ${Colors.blue.value}',
      );
    }
  }

  Future<String> insertDDayEvent(DDayEvent event) async {
    final db = await database;
    await db.insert(
      'dday_events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return event.id;
  }

  Future<List<DDayEvent>> getAllDDayEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dday_events');
    return List.generate(maps.length, (i) => DDayEvent.fromMap(maps[i]));
  }

  Future<DDayEvent?> getDDayEvent(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'dday_events',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return DDayEvent.fromMap(maps.first);
  }

  Future<int> updateDDayEvent(DDayEvent event) async {
    final db = await database;
    return await db.update(
      'dday_events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteDDayEvent(String id) async {
    final db = await database;
    return await db.delete('dday_events', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllDDayEvents() async {
    final db = await database;
    await db.delete('dday_events');
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
