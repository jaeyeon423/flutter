import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/dday_event.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  static Database? _database;

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

  Future<void> insertDDayEvent(DDayEvent event) async {
    final db = await database;
    await db.insert('dday_events', {
      'id': event.id,
      'title': event.title,
      'targetDate': event.targetDate.toIso8601String(),
      'type': event.type.toString(),
      'createdAt': event.createdAt.toIso8601String(),
      'color': event.color.value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DDayEvent>> getDDayEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dday_events');

    return List.generate(maps.length, (i) {
      return DDayEvent(
        id: maps[i]['id'],
        title: maps[i]['title'],
        targetDate: DateTime.parse(maps[i]['targetDate']),
        type: DDayType.values.firstWhere(
          (e) => e.toString() == maps[i]['type'],
          orElse: () => DDayType.oneTime,
        ),
        createdAt: DateTime.parse(maps[i]['createdAt']),
        color: Color(maps[i]['color']),
      );
    });
  }

  Future<void> updateDDayEvent(DDayEvent event) async {
    final db = await database;
    await db.update(
      'dday_events',
      {
        'title': event.title,
        'targetDate': event.targetDate.toIso8601String(),
        'type': event.type.toString(),
        'createdAt': event.createdAt.toIso8601String(),
        'color': event.color.value,
      },
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteDDayEvent(String id) async {
    final db = await database;
    await db.delete('dday_events', where: 'id = ?', whereArgs: [id]);
  }
}
