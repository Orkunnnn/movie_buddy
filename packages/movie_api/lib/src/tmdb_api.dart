import 'dart:convert';
import 'dart:io' if (dart.library.html) "dart:html";

import "package:http/http.dart" as http;
import 'package:movie_api/src/errors/errors.dart';
import 'package:movie_api/src/models/models.dart';

class MovieApi {
  MovieApi({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client() {
    key = const String.fromEnvironment("TMDB_KEY");
  }

  static const String _baseUrl = "api.themoviedb.org";
  static const String _moviePath = "/3/movie";
  late String key;
  final http.Client _httpClient;

  Future<RawMovieDetails> getDetails(int movieId, String languageCode) async {
    final movieDetailsRequest = Uri.https(
      _baseUrl,
      "$_moviePath/$movieId",
      {"api_key": key, "language": languageCode},
    );
    final movieDetailsResponse = await _httpClient.get(movieDetailsRequest);

    if (movieDetailsResponse.statusCode != HttpStatus.ok) {
      throw MovieRequestFailure();
    }

    final movieDetailsJson =
        jsonDecode(movieDetailsResponse.body) as Map<String, dynamic>;

    return RawMovieDetails.fromJson(movieDetailsJson);
  }

  Future<List<RawMovie>> getMoviesPopular(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesPopularRequest = Uri.https(
      _baseUrl,
      "$_moviePath/popular",
      {"api_key": key, "language": languageCode, "page": "$pageNumber"},
    );

    final moviesPopularResponse = await _httpClient.get(moviesPopularRequest);

    if (moviesPopularResponse.statusCode != HttpStatus.ok) {
      throw MovieRequestFailure();
    }

    final moviesPopularJson =
        jsonDecode(moviesPopularResponse.body) as Map<String, dynamic>;

    if (!moviesPopularJson.containsKey("results")) throw MovieNotFound();

    final results = moviesPopularJson["results"] as List;

    return results
        .map((e) => RawMovie.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<RawMovie>> getMoviesTopRated(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesTopRatedRequest = Uri.https(
      _baseUrl,
      "$_moviePath/top_rated",
      {"api_key": key, "language": languageCode, "page": "$pageNumber"},
    );

    final moviesTopRatedResponse = await _httpClient.get(moviesTopRatedRequest);

    if (moviesTopRatedResponse.statusCode != HttpStatus.ok) {
      throw MovieRequestFailure();
    }

    final moviesTopRatedJson =
        jsonDecode(moviesTopRatedResponse.body) as Map<String, dynamic>;

    if (!moviesTopRatedJson.containsKey("results")) throw MovieNotFound();

    final results = moviesTopRatedJson["results"] as List;

    return results
        .map((e) => RawMovie.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<RawMovie>> getMoviesNowPlaying(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesNowPlayingRequest = Uri.https(
      _baseUrl,
      "$_moviePath/now_playing",
      {"api_key": key, "language": languageCode, "page": "$pageNumber"},
    );

    final moviesNowPlayingResponse =
        await _httpClient.get(moviesNowPlayingRequest);

    if (moviesNowPlayingResponse.statusCode != HttpStatus.ok) {
      throw MovieRequestFailure();
    }

    final moviesNowPlayingJson =
        jsonDecode(moviesNowPlayingResponse.body) as Map<String, dynamic>;

    if (!moviesNowPlayingJson.containsKey("results")) throw MovieNotFound();

    final results = moviesNowPlayingJson["results"] as List;

    return results
        .map((e) => RawMovie.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
