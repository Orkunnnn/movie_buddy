import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy_ui/src/widgets/widgets.dart';

void main() {
  group(
    "Clickable",
    () {
      testWidgets(
        "makes given child clickable",
        (tester) async {
          var wasClicked = false;
          await tester.pumpWidget(
            MaterialApp(
              home: Clickable(
                onPressed: () => wasClicked = true,
                child: const Text("Click Me!"),
              ),
            ),
          );
          expect(find.text("Click Me!"), findsOneWidget);
          expect(wasClicked, isFalse);
          await tester.tap(find.byType(Clickable));
          await tester.pumpAndSettle();
          expect(wasClicked, isTrue);
        },
      );
    },
  );
}
