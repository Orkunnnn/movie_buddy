import 'package:movie_repository/src/models/movie_details.dart';
import 'package:test/test.dart';

void main() {
  group(
    "MovieDetails",
    () {
      test(
        "supports value equality",
        () {
          expect(
            const MovieDetails(
              title: "title",
              overview: "overview",
              status: "status",
              tagline: "tagline",
              releaseDate: "releaseDate",
              posterPathFull: "posterPathFull",
              genres: [],
            ),
            const MovieDetails(
              title: "title",
              overview: "overview",
              status: "status",
              tagline: "tagline",
              releaseDate: "releaseDate",
              posterPathFull: "posterPathFull",
              genres: [],
            ),
          );
        },
      );
    },
  );
}
