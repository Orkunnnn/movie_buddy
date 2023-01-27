import 'package:movie_api/src/models/raw_genre.dart';
import 'package:movie_api/src/models/raw_movie_details.dart';
import 'package:test/test.dart';

void main() {
  group(
    "RawMovieDetails",
    () {
      group(
        "fromJson",
        () {
          test(
            "works correctly",
            () {
              expect(
                RawMovieDetails(
                  "title",
                  "overview",
                  "status",
                  "tagline",
                  "releaseDate",
                  "posterPath",
                  [],
                ).toJson(),
                {
                  "title": "title",
                  "overview": "overview",
                  "status": "status",
                  "tagline": "tagline",
                  "release_date": "releaseDate",
                  "poster_path": "posterPath",
                  "genres": <RawGenre>[]
                },
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
              expect(
                RawMovieDetails.fromJson({
                  "title": "title",
                  "overview": "overview",
                  "status": "status",
                  "tagline": "tagline",
                  "release_date": "releaseDate",
                  "poster_path": "posterPath",
                  "genres": <RawGenre>[]
                }).toJson(),
                {
                  "title": "title",
                  "overview": "overview",
                  "status": "status",
                  "tagline": "tagline",
                  "release_date": "releaseDate",
                  "poster_path": "posterPath",
                  "genres": <RawGenre>[]
                },
              );
            },
          );
        },
      );
    },
  );
}
