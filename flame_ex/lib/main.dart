import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget<MyGame>.controlled(gameFactory: MyGame.new));
}

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    // 게임 초기화 코드를 여기에 작성하세요
    super.onLoad();
  }

  @override
  void update(double dt) {
    // 게임 업데이트 로직을 여기에 작성하세요
    super.update(dt);
  }
}