import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../models/dday_event.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'dday_database.db');

    // Delete existing database file
    final dbFile = File(path);
    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dday_events(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        targetDate TEXT NOT NULL,
        countAsDayOne INTEGER NOT NULL,
        color INTEGER NOT NULL,
        showInNotification INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add color column if it doesn't exist
      try {
        await db.execute(
          'ALTER TABLE dday_events ADD COLUMN color INTEGER NOT NULL DEFAULT 4280391411',
        );
      } catch (e) {
        // Column might already exist, ignore the error
      }
    }

    if (oldVersion < 3) {
      // Add showInNotification column if it doesn't exist
      try {
        await db.execute(
          'ALTER TABLE dday_events ADD COLUMN showInNotification INTEGER NOT NULL DEFAULT 0',
        );
      } catch (e) {
        // Column might already exist, ignore the error
      }
    }
  }

  Future<void> insertDDayEvent(DDayEvent event) async {
    final db = await database;
    await db.insert('dday_events', {
      'id': event.id,
      'title': event.title,
      'targetDate': event.targetDate.toIso8601String(),
      'countAsDayOne': event.countAsDayOne ? 1 : 0,
      'color': event.color.value,
      'showInNotification': event.showInNotification ? 1 : 0,
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
        countAsDayOne: maps[i]['countAsDayOne'] == 1,
        color: Color(maps[i]['color']),
        showInNotification: maps[i]['showInNotification'] == 1,
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
        'countAsDayOne': event.countAsDayOne ? 1 : 0,
        'color': event.color.value,
        'showInNotification': event.showInNotification ? 1 : 0,
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
