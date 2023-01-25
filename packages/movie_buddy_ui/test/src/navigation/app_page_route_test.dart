import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockAnimation extends Mock implements Animation<double> {}

void main() {
  group(
    "AppPageRoute",
    () {
      testWidgets(
        "is a MaterialPageRoute",
        (widgetTester) async {
          final route = AppPageRoute<void>(
            builder: (context) => const SizedBox(),
          );
          expect(route, isA<MaterialPageRoute<void>>());
        },
      );
      testWidgets(
        "has no transition",
        (widgetTester) async {
          const child = SizedBox();
          final transition = AppPageRoute<void>(
            builder: (context) => child,
          ).buildTransitions(
            MockBuildContext(),
            MockAnimation(),
            MockAnimation(),
            child,
          );
          expect(transition, equals(child));
        },
      );
    },
  );
}
