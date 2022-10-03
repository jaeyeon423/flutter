import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final database = openDatabase(
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
    Future<void> insertDog(Favorite favor) async {
      // 데이터베이스 reference를 얻습니다.
      final Database db = await database;

      // Dog를 올바른 테이블에 추가하세요. 또한
      // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
      // 만약 동일한 dog가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
      await db.insert(
        'favor',
        favor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<List<Favorite>> dogs() async {
      // 데이터베이스 reference를 얻습니다.
      final Database db = await database;

      // 모든 Dog를 얻기 위해 테이블에 질의합니다.
      final List<Map<String, dynamic>> maps = await db.query('favor');

      // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
      return List.generate(maps.length, (i) {
        return Favorite(
          id: maps[i]['id'],
          name: maps[i]['name'],
        );
      });
    }

    Future<void> updateDog(Favorite favor) async {
      // 데이터베이스 reference를 얻습니다.
      final db = await database;

      // 주어진 Dog를 수정합니다.
      await db.update(
        'favor',
        favor.toMap(),
        // Dog의 id가 일치하는 지 확인합니다.
        where: "id = ?",
        // Dog의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
        whereArgs: [favor.id],
      );
    }

    Future<void> deleteDog(int id) async {
      // 데이터베이스 reference를 얻습니다.
      final db = await database;

      // 데이터베이스에서 Dog를 삭제합니다.
      await db.delete(
        'favor',
        // 특정 dog를 제거하기 위해 `where` 절을 사용하세요
        where: "id = ?",
        // Dog의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
        whereArgs: [id],
      );
    }

    var fido = Favorite(
      id: 1,
      name: 'jaeyeon',
    );

    // 데이터베이스에 dog를 추가합니다.
    await insertDog(fido);

    // dog 목록을 출력합니다. (지금은 Fido만 존재합니다.)
    print(await dogs());

    // Fido의 나이를 수정한 뒤 데이터베이스에 저장합니다.
    fido = Favorite(
      id: fido.id,
      name: fido.name,
    );
    await updateDog(fido);

    // Fido의 수정된 정보를 출력합니다.
    print(await dogs());

    // Fido를 데이터베이스에서 제거합니다.
    // await deleteDog(fido.id);

    // dog 목록을 출력합니다. (비어있습니다.)
    print(await dogs());
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

  // 각 dog 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Dog{id: $id, name: $name}';
  }
}
