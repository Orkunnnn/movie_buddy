import 'package:movie_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group(
    "RawGenre",
    () {
      group(
        "fromJson",
        () {
          test(
            "works correctly",
            () {
              expect(
                RawGenre.fromJson({"id": 1, "name": "Comedy"}),
                isA<RawGenre>()
                    .having((genre) => genre.id, "id", 1)
                    .having((genre) => genre.name, "name", "Comedy"),
              );
            },
          );
        },
      );
      group(
        "toJson",
        () {
          test(
            "works correctly",
            () {
              final genre = RawGenre(id: 1, name: "Comedy");
              expect(genre.toJson(), {"id": 1, "name": "Comedy"});
            },
          );
        },
      );
    },
  );
}
