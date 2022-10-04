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
    // TODO: implement onInit
    super.onInit();
    database = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'favorite.db'),
      // 데이터베이스가 처음 생성될 때, dog를 저장하기 위한 테이블을 생성합니다.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE favor(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );

    insertFavor(Favorite(id: 1, name: "dong"));
    print(updateFavor());
    print(favor_list);
  }

  Future<void> insertFavor(Favorite favor) async {
    final Database db = await database;
    await db.insert(
      'favor',
      favor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Favorite>> updateFavor() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favor');
    return List.generate(maps.length, (i) {
      print(maps[i]['id']);
      favor_list.add(maps[i]['id']);
      update(favor_list);
      return Favorite(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<void> deleteFavor(int id) async {
    final db = await database;
    await db.delete(
      'favor',
      where: "id = ?",
      whereArgs: [id],
    );
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
