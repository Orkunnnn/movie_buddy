import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/src/models/genre.dart';
import 'package:test/test.dart';

void main() {
  group(
    "Genre",
    () {
      test(
        "supports value equality",
        () {
          expect(
            const Genre(id: 1, name: "Comedy"),
            const Genre(id: 1, name: "Comedy"),
          );
        },
      );
      test(
        "returns Genre from RawGenre",
        () {
          final rawGenre = RawGenre(id: 1, name: "Comedy");
          expect(
            Genre.fromRawGenre(rawGenre),
            const Genre(id: 1, name: "Comedy"),
          );
        },
      );
    },
  );
}
