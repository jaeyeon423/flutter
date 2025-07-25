import 'package:flutter_test/flutter_test.dart';
import 'package:flame_ex/main.dart';

void main() {
  testWidgets('Game loads successfully', (WidgetTester tester) async {
    // Test that the game widget can be created without errors
    await tester.pumpWidget(MyGame().toWidget());
    expect(find.byType(MyGame), findsOneWidget);
  });
}
