import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy_ui/src/theme.dart';

void main() {
  group(
    "MovieBuddyTheme.themeData",
    () {
      test(
        "is defined for dark and darkSmall",
        () {
          expect(MovieBuddyTheme.dark, isA<ThemeData>());
          expect(MovieBuddyTheme.darkSmall, isA<ThemeData>());
        },
      );
    },
  );
}
