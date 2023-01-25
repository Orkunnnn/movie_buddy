import 'package:movie_api/src/env/env.dart';
import 'package:test/test.dart';

void main() {
  group(
    "Env",
    () {
      test(
        "tmdbApiKey is not null",
        () {
          expect(Env.tmdbApiKey, isNotNull);
        },
      );
    },
  );
}
