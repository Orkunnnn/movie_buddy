import 'dart:convert';
import 'dart:io' if (dart.library.html) "dart:html";

import "package:http/http.dart" as http;
import 'package:movie_api/src/env/env.dart';
import 'package:movie_api/src/errors/errors.dart';
import 'package:movie_api/src/models/models.dart';

class MovieApi {
  MovieApi({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  static const String _baseUrl = "api.themoviedb.org";
  static const String _moviePath = "/3/movie";
  final http.Client _httpClient;

  Future<RawMovieDetails> getDetails(int movieId, String languageCode) async {
    final movieDetailsRequest = Uri.https(
      _baseUrl,
      "$_moviePath/$movieId",
      {"api_key": Env.tmdbApiKey, "language": languageCode},
    );
    final movieDetailsResponse = await _httpClient.get(movieDetailsRequest);

    if (movieDetailsResponse.statusCode != HttpStatus.ok) {
      throw MovieRequestFailure();
    }

    final movieDetailsJson =
        jsonDecode(movieDetailsResponse.body) as Map<String, dynamic>;

    return RawMovieDetails.fromJson(movieDetailsJson);
  }

  Future<List<RawMovie>> getPopular(String languageCode) async {
    final moviePopularRequest = Uri.https(
      _baseUrl,
      "$_moviePath/popular",
      {"api_key": Env.tmdbApiKey, "language": languageCode},
    );

    final moviePopularResponse = await _httpClient.get(moviePopularRequest);

    if (moviePopularResponse.statusCode != HttpStatus.ok) {
      throw MovieRequestFailure();
    }

    final moviePopularJson =
        jsonDecode(moviePopularResponse.body) as Map<String, dynamic>;

    if (!moviePopularJson.containsKey("results")) throw MovieNotFound();

    final results = moviePopularJson["results"] as List;

    return results
        .map((e) => RawMovie.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
