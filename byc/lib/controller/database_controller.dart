import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  RxList<int> favor_list = <int>[].obs;
  late final database;

  @override
  void onInit() async {
    super.onInit();
    database = openDatabase(
      join(await getDatabasesPath(), 'favorite.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE favor(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
    updateFavor();
  }

  Future<void> insertFavor(Favorite favor) async {
    final Database db = await database;
    print(favor.id);
    if (!favor_list.contains(favor.id)) {
      await db.insert(
        'favor',
        favor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      favor_list.add(favor.id);
      update(favor_list);
    }
  }

  Future<List<Favorite>> updateFavor() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favor');
    return List.generate(
      maps.length,
      (i) {
        return Favorite(
          id: maps[i]['id'],
          name: maps[i]['name'],
        );
      },
    );
  }

  Future<void> deleteFavor(int id) async {
    final db = await database;
    await db.delete(
      'favor',
      where: "id = ?",
      whereArgs: [id],
    );
    if (favor_list.contains(id)) {
      favor_list.remove(id);
    }
  }
}

class Favorite {
  final int id;
  final String name;

  Favorite({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'favor{id: $id, name: $name}';
  }
}
