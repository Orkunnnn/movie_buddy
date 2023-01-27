import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';

void main() {
  group(
    "isMobile",
    () {
      test(
        "returns true",
        () {
          expect(isMobile, isTrue);
        },
      );
    },
  );
}
