import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/src/models/movie.dart';
import 'package:test/test.dart';

void main() {
  group(
    "Movie",
    () {
      test(
        "supports value equality",
        () {
          expect(
            const Movie(
              title: "title",
              overview: "overview",
              releaseDate: "releaseDate",
              posterPathFull: "posterPathFull",
              genres: [],
            ),
            const Movie(
              title: "title",
              overview: "overview",
              releaseDate: "releaseDate",
              posterPathFull: "posterPathFull",
              genres: [],
            ),
          );
        },
      );
      test(
        "returns Movie from RawMovie",
        () {
          final rawMovie =
              RawMovie("title", "overview", "releaseDate", "posterPath", []);
          expect(
            Movie.fromRawMovie(rawMovie),
            const Movie(
              title: "title",
              overview: "overview",
              releaseDate: "releaseDate",
              posterPathFull: "https://image.tmdb.org/t/p/original/posterPath",
              genres: [],
            ),
          );
        },
      );
    },
  );
}
