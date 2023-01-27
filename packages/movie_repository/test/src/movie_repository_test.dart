import 'package:mocktail/mocktail.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/src/models/movie.dart';
import 'package:movie_repository/src/models/movie_details.dart';
import 'package:movie_repository/src/movie_repository.dart';
import 'package:test/test.dart';

import '../helpers/movie_helpers.dart';

class MockMovieApi extends Mock implements MovieApi {}

class MockRawMovieDetails extends Mock implements RawMovieDetails {}

class MockRawMovie extends Mock implements RawMovie {}

void main() {
  group(
    "MovieRepository",
    () {
      const movieId = 1;
      const languageCode = "tr";

      late MovieApi movieApi;
      late MovieRepository movieRepository;

      setUp(
        () {
          movieApi = MockMovieApi();
          movieRepository = MovieRepository(movieApi: movieApi);
        },
      );
      test(
        "does not require MovieApi instance",
        () {
          expect(MovieRepository(), isNotNull);
        },
      );
      group(
        "getMovieDetails",
        () {
          test(
            "calls getMovieDetails with correct parameters",
            () async {
              try {
                await movieRepository.getMovieDetails(movieId, languageCode);
              } catch (_) {}
              verify(
                () => movieApi.getMovieDetails(movieId, languageCode),
              ).called(1);
            },
          );
          test(
            "throws exception when getMovieDetails fails",
            () async {
              final exception = Exception();
              when(
                () => movieApi.getMovieDetails(movieId, languageCode),
              ).thenThrow(exception);
              await expectLater(
                movieRepository.getMovieDetails(movieId, languageCode),
                throwsA(exception),
              );
            },
          );
          test(
            "returns correct movieDetails on success",
            () async {
              final movieDetails = getMockRawMovieDetails();
              when(
                () => movieApi.getMovieDetails(movieId, languageCode),
              ).thenAnswer((invocation) async => movieDetails);
              final actual =
                  await movieRepository.getMovieDetails(movieId, languageCode);
              expect(
                actual,
                const MovieDetails(
                  title: "title",
                  overview: "overview",
                  status: "status",
                  tagline: "tagline",
                  releaseDate: "releaseDate",
                  posterPathFull:
                      "https://image.tmdb.org/t/p/original/posterPath",
                  genres: [],
                ),
              );
            },
          );
        },
      );
      group(
        "getMoviesPopular",
        () {
          test(
            "calls getMoviesPopular with correct parameters",
            () async {
              try {
                await movieRepository.getMoviesPopular(languageCode);
              } catch (_) {
                verify(
                  () => movieApi.getMoviesPopular(languageCode, 1),
                );
              }
            },
          );
          test(
            "throws exception when getMoviesPopular fails",
            () async {
              final exception = Exception();
              when(
                () => movieApi.getMoviesPopular(languageCode, 1),
              ).thenThrow(exception);
              await expectLater(
                movieRepository.getMoviesPopular(languageCode),
                throwsA(exception),
              );
            },
          );
          test(
            "returns correct Movie list on success",
            () async {
              final rawMovie = getMockRawMovie();
              when(
                () => movieApi.getMoviesPopular(languageCode, 1),
              ).thenAnswer((invocation) async => [rawMovie]);
              final actual =
                  await movieRepository.getMoviesPopular(languageCode);
              expect(actual, [
                const Movie(
                  title: "title",
                  overview: "overview",
                  releaseDate: "releaseDate",
                  posterPathFull:
                      "https://image.tmdb.org/t/p/original/posterPath",
                  genres: [],
                )
              ]);
            },
          );
        },
      );
      group(
        "getMoviesTopRated",
        () {
          test(
            "calls getMoviesTopRated with correct parameters",
            () async {
              try {
                await movieRepository.getMoviesTopRated(languageCode);
              } catch (_) {
                verify(
                  () => movieApi.getMoviesTopRated(languageCode, 1),
                ).called(1);
              }
            },
          );
          test(
            "throws exception when getMoviesTopRated fails",
            () async {
              final exception = Exception();
              when(
                () => movieApi.getMoviesTopRated(languageCode, 1),
              ).thenThrow(exception);
              await expectLater(
                movieRepository.getMoviesTopRated(languageCode),
                throwsA(exception),
              );
            },
          );
          test(
            "returns correct Movie list on success",
            () async {
              final rawMovie = getMockRawMovie();
              when(
                () => movieApi.getMoviesTopRated(languageCode, 1),
              ).thenAnswer((invocation) async => [rawMovie]);
              final actual =
                  await movieRepository.getMoviesTopRated(languageCode);
              expect(
                actual,
                [
                  const Movie(
                    title: "title",
                    overview: "overview",
                    releaseDate: "releaseDate",
                    posterPathFull:
                        "https://image.tmdb.org/t/p/original/posterPath",
                    genres: [],
                  )
                ],
              );
            },
          );
        },
      );
      group(
        "getMoviesNowPlaying",
        () {
          test(
            "calls getMoviesNowPlaying with correct parameters",
            () async {
              try {
                await movieRepository.getMoviesNowPlaying(languageCode);
              } catch (_) {
                verify(
                  () => movieApi.getMoviesNowPlaying(languageCode, 1),
                ).called(1);
              }
            },
          );
          test(
            "throws exception when getMoviesNowPlaying",
            () async {
              final exception = Exception();
              when(
                () => movieApi.getMoviesNowPlaying(languageCode, 1),
              ).thenThrow(exception);
              await expectLater(
                movieRepository.getMoviesNowPlaying(languageCode),
                throwsA(exception),
              );
            },
          );
          test(
            "returns correct Movie list on success",
            () async {
              final rawMovie = getMockRawMovie();
              when(
                () => movieApi.getMoviesNowPlaying(languageCode, 1),
              ).thenAnswer((invocation) async => [rawMovie]);
              final actual =
                  await movieRepository.getMoviesNowPlaying(languageCode);
              expect(
                actual,
                [
                  const Movie(
                    title: "title",
                    overview: "overview",
                    releaseDate: "releaseDate",
                    posterPathFull:
                        "https://image.tmdb.org/t/p/original/posterPath",
                    genres: [],
                  )
                ],
              );
            },
          );
        },
      );
    },
  );
}
