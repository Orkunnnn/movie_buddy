import "package:http/http.dart" as http;
import 'package:mocktail/mocktail.dart';
import 'package:movie_api/src/errors/errors.dart';
import 'package:movie_api/src/models/raw_genre.dart';
import 'package:movie_api/src/models/raw_movie.dart';
import 'package:movie_api/src/models/raw_movie_details.dart';
import 'package:movie_api/src/tmdb_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group(
    "TmdbApi",
    () {
      const baseUrl = "api.themoviedb.org";
      late http.Client httpClient;
      late MovieApi movieApi;
      late String key;

      setUp(
        () {
          httpClient = MockHttpClient();
          movieApi = MovieApi(httpClient: httpClient);
          key = const String.fromEnvironment("TMDB_KEY");
        },
      );
      setUpAll(
        () {
          registerFallbackValue(FakeUri());
        },
      );
      group(
        "getDetails",
        () {
          test(
            "makes correct http request",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              try {
                await movieApi.getMovieDetails(2, "tr");
              } catch (_) {}
              verify(
                () => httpClient.get(
                  Uri.https(
                    "api.themoviedb.org",
                    "/3/movie/2",
                    {"api_key": key, "language": "tr"},
                  ),
                ),
              );
            },
          );
          test(
            "throws MovieRequestFailure on non-200 response",
            () async {
              final response = MockResponse();
              when(() => response.statusCode).thenReturn(400);
              when(() => httpClient.get(any()))
                  .thenAnswer((_) async => response);
              await expectLater(
                movieApi.getMovieDetails(2, "tr"),
                throwsA(isA<MovieRequestFailure>()),
              );
            },
          );
          test(
            "returns RawMovieDetails on valid response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn('''
                {
                  "tagline": "",
                  "title": "Megan",
                  "poster_path": "34fsf3gbxdsf.png",
                  "overview": "Film hakkında bilgi",
                  "status": "released",
                  "release_date": "1990-12-01",
                  "genres": [
                    {
                    "id": 1,
                    "name": "Comedy"
                    }
                  ]
                }''');
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              final actual = await movieApi.getMovieDetails(2, "tr");
              expect(
                actual,
                isA<RawMovieDetails>()
                    .having((p0) => p0.title, "title", "Megan")
                    .having(
                      (p0) => p0.overview,
                      "overview",
                      "Film hakkında bilgi",
                    )
                    .having((p0) => p0.status, "status", "released")
                    .having((p0) => p0.tagline, "tagline", "")
                    .having(
                      (p0) => p0.releaseDate,
                      "release_date",
                      "1990-12-01",
                    )
                    .having(
                      (p0) => p0.posterPath,
                      "poster_path",
                      "34fsf3gbxdsf.png",
                    )
                    .having(
                  (p0) => p0.genres,
                  "genres",
                  [
                    isA<RawGenre>()
                        .having((p0) => p0.id, "id", 1)
                        .having((p0) => p0.name, "name", "Comedy")
                  ],
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
            "makes correct http request",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              try {
                await movieApi.getMoviesPopular("tr", 1);
              } catch (_) {}
              verify(
                () => httpClient.get(
                  Uri.https(
                    baseUrl,
                    "/3/movie/popular",
                    {"api_key": key, "language": "tr", "page": "1"},
                  ),
                ),
              ).called(1);
            },
          );
          test(
            "throws MovieRequestFailure on non-200 response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(400);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              await expectLater(
                movieApi.getMoviesPopular("tr", 1),
                throwsA(isA<MovieRequestFailure>()),
              );
            },
          );
          test(
            "throws MovieNotFound on empty response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              await expectLater(
                movieApi.getMoviesPopular("tr", 1),
                throwsA(isA<MovieNotFound>()),
              );
            },
          );
          test(
            "returns RawMovie on valid response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn('''
                {
                  "results": [
                  {
                    "title": "title",
                    "overview": "overview",
                    "release_date": "releaseDate",
                    "poster_path": "posterPath",
                    "genres": [
                      1,
                      2
                    ]
                  }
                ]
                }
                ''');
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              final actual = await movieApi.getMoviesPopular("tr", 1);
              expect(actual, [
                isA<RawMovie>()
                    .having((p0) => p0.title, "title", "title")
                    .having((p0) => p0.overview, "overview", "overview")
                    .having(
                      (p0) => p0.releaseDate,
                      "release_date",
                      "releaseDate",
                    )
                    .having(
                      (p0) => p0.posterPath,
                      "poster_path",
                      "posterPath",
                    )
                    .having((p0) => p0.genres, "genres", [1, 2]),
              ]);
            },
          );
        },
      );
      group(
        "getMoviesTopRated",
        () {
          test(
            "makes correct http request",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              try {
                await movieApi.getMoviesTopRated("tr", 1);
              } catch (_) {}
              verify(
                () => httpClient.get(
                  Uri.https(
                    baseUrl,
                    "/3/movie/top_rated",
                    {"api_key": key, "language": "tr", "page": "1"},
                  ),
                ),
              ).called(1);
            },
          );
          test(
            "throws MovieRequestFailure on non-200 response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(400);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              await expectLater(
                movieApi.getMoviesTopRated("tr", 1),
                throwsA(isA<MovieRequestFailure>()),
              );
            },
          );
          test(
            "throws MovieNotFound on empty response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              await expectLater(
                movieApi.getMoviesTopRated("tr", 1),
                throwsA(isA<MovieNotFound>()),
              );
            },
          );
          test(
            "returns RawMovie on valid response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn('''
                {
                  "results": [
                  {
                    "title": "title",
                    "overview": "overview",
                    "release_date": "releaseDate",
                    "poster_path": "posterPath",
                    "genres": [
                      1,
                      2
                    ]
                  }
                ]
                }
                ''');
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              final actual = await movieApi.getMoviesTopRated("tr", 1);
              expect(actual, [
                isA<RawMovie>()
                    .having((p0) => p0.title, "title", "title")
                    .having((p0) => p0.overview, "overview", "overview")
                    .having(
                      (p0) => p0.releaseDate,
                      "release_date",
                      "releaseDate",
                    )
                    .having(
                      (p0) => p0.posterPath,
                      "poster_path",
                      "posterPath",
                    )
                    .having((p0) => p0.genres, "genres", [1, 2]),
              ]);
            },
          );
        },
      );
      group(
        "getNowPlaying",
        () {
          test(
            "makes correct http request",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              try {
                await movieApi.getMoviesNowPlaying("tr", 1);
              } catch (_) {}
              verify(
                () => httpClient.get(
                  Uri.https(
                    baseUrl,
                    "/3/movie/now_playing",
                    {"api_key": key, "language": "tr", "page": "1"},
                  ),
                ),
              ).called(1);
            },
          );
          test(
            "throws MovieRequestFailure on non-200 response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(400);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              await expectLater(
                movieApi.getMoviesNowPlaying("tr", 1),
                throwsA(isA<MovieRequestFailure>()),
              );
            },
          );
          test(
            "throws MovieNotFound on empty response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn("{}");
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              await expectLater(
                movieApi.getMoviesNowPlaying("tr", 1),
                throwsA(isA<MovieNotFound>()),
              );
            },
          );
          test(
            "returns RawMovie on valid response",
            () async {
              final response = MockResponse();
              when(
                () => response.statusCode,
              ).thenReturn(200);
              when(
                () => response.body,
              ).thenReturn('''
                {
                  "results": [
                  {
                    "title": "title",
                    "overview": "overview",
                    "release_date": "releaseDate",
                    "poster_path": "posterPath",
                    "genres": [
                      1,
                      2
                    ]
                  }
                ]
                }
                ''');
              when(
                () => httpClient.get(any()),
              ).thenAnswer((invocation) async => response);
              final actual = await movieApi.getMoviesNowPlaying("tr", 1);
              expect(actual, [
                isA<RawMovie>()
                    .having((p0) => p0.title, "title", "title")
                    .having((p0) => p0.overview, "overview", "overview")
                    .having(
                      (p0) => p0.releaseDate,
                      "release_date",
                      "releaseDate",
                    )
                    .having(
                      (p0) => p0.posterPath,
                      "poster_path",
                      "posterPath",
                    )
                    .having((p0) => p0.genres, "genres", [1, 2]),
              ]);
            },
          );
        },
      );
    },
  );
}
