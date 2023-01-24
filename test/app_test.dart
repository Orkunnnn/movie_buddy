import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy/app.dart';

void main() {
  group(
    "App",
    () {
      testWidgets(
        "renders AppView",
        (tester) async {
          await tester.pumpWidget(const App());
          expect(find.byType(AppView), findsOneWidget);
        },
      );
    },
  );
  group(
    "AppView",
    () {
      testWidgets(
        "renders AppBar",
        (tester) async {
          await tester.pumpWidget(const MaterialApp(
            home: AppView(),
          ));
          expect(find.byType(AppBar), findsOneWidget);
        },
      );
      group(
        "AppBar",
        () {
          testWidgets(
            "renders title",
            (tester) async {
              await tester.pumpWidget(const MaterialApp(
                home: AppView(),
              ));
              expect(find.text("Movie Buddy"), findsOneWidget);
            },
          );
        },
      );
    },
  );
}
