import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with DragCallbacks {
  late MyCircleComponent myCircle;
  Vector2? dragStart;
  Vector2? dragDelta;
  double speed = 100; // 공의 속도 (pixels/second)
  bool isDragging = false; // 드래그 중인지 여부

  @override
  Future<void> onLoad() async {
    myCircle = MyCircleComponent(
      radius: 20,
      position: size / 2,
      paint: Paint()..color = Colors.black,
      anchor: Anchor.center,
    );
    add(myCircle);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.white, BlendMode.src);
    super.render(canvas);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    dragStart = event.canvasPosition;
    dragDelta = null; // 이전 드래그 방향 정보 초기화
    isDragging = true; // 드래그 시작
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (dragStart != null) {
      dragDelta = event.canvasPosition - dragStart!;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    dragStart = null; // 드래그 시작 위치 초기화
    dragDelta = null; // 드래그 방향 정보 초기화
    isDragging = false; // 드래그 종료
  }

  @override
  void update(double dt) {
    super.update(dt);
    // isDragging이 true일 때만 공을 이동
    if (isDragging && dragDelta != null) {
      Vector2 direction = dragDelta!.normalized(); // 정규화된 방향 벡터
      myCircle.position += direction * speed * dt; // 속도에 따라 이동

      // 화면 경계 체크
      myCircle.position.setValues(
        myCircle.position.x.clamp(myCircle.radius, size.x - myCircle.radius),
        myCircle.position.y.clamp(myCircle.radius, size.y - myCircle.radius),
      );
    }
  }
}

class MyCircleComponent extends CircleComponent {
  MyCircleComponent({
    required double radius,
    required Paint paint,
    required Vector2 position,
    required Anchor anchor,
  }) : super(
          radius: radius,
          paint: paint,
          position: position,
          anchor: anchor,
        );
}

class PlayWidget extends StatelessWidget {
  // GameWidget -> PlayWidget
  const PlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: MyGame(),
      ),
    );
  }
}
