import 'package:flame/game.dart';
import 'package:flame/events.dart';
import '../components/ball.dart';
import '../components/hole.dart';
import '../components/background.dart';

class GolfGame extends FlameGame with DragCallbacks {
  late final Ball ball;
  late final Hole hole;
  late final Background background;
  Vector2? dragStartPosition;
  Vector2? currentDragPosition;

  @override
  Future<void> onLoad() async {
    // Add background
    background = Background();
    add(background);

    // Add hole
    hole = Hole();
    add(hole);

    // Add ball
    ball = Ball();
    add(ball);
  }

  @override
  bool onDragStart(DragStartEvent event) {
    dragStartPosition = event.canvasPosition;
    currentDragPosition = event.canvasPosition;
    ball.startDrag(dragStartPosition!);
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    if (dragStartPosition != null) {
      currentDragPosition = event.canvasPosition;
      ball.updateDrag(currentDragPosition!);
    }
    return true;
  }

  @override
  bool onDragEnd(DragEndEvent event) {
    if (dragStartPosition != null && currentDragPosition != null) {
      ball.endDrag(currentDragPosition!);
      dragStartPosition = null;
      currentDragPosition = null;
    }
    return true;
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    dragStartPosition = null;
    currentDragPosition = null;
    ball.cancelDrag();
  }
}
