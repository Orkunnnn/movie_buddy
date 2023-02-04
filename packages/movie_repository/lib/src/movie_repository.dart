import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/src/models/models.dart';

class MovieRepository {
  MovieRepository({MovieApi? movieApi}) : _movieApi = movieApi ?? MovieApi();

  final MovieApi _movieApi;

  Future<MovieDetails> getMovieDetails(int movieId, String languageCode) async {
    final movieDetails = await _movieApi.getMovieDetails(movieId, languageCode);
    return MovieDetails.fromRawMovieDetails(movieDetails);
  }

  Future<Set<Movie>> getMoviesPopular(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesPopular = await Future.delayed(
      const Duration(seconds: 2),
      () async => _movieApi.getMoviesPopular(languageCode, pageNumber),
    );
    return moviesPopular.map(Movie.fromRawMovie).toSet();
  }

  Future<Set<Movie>> getMoviesTopRated(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesTopRated =
        await _movieApi.getMoviesTopRated(languageCode, pageNumber);
    return moviesTopRated.map(Movie.fromRawMovie).toSet();
  }

  Future<List<Movie>> getMoviesNowPlaying(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesNowPlaying =
        await _movieApi.getMoviesNowPlaying(languageCode, pageNumber);
    return moviesNowPlaying.map(Movie.fromRawMovie).toList();
  }
}
