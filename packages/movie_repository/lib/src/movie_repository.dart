import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/src/models/movie.dart';
import 'package:movie_repository/src/models/movie_details.dart';

class MovieRepository {
  MovieRepository({MovieApi? movieApi}) : _movieApi = movieApi ?? MovieApi();

  final MovieApi _movieApi;

  Future<MovieDetails> getMovieDetails(int movieId, String languageCode) async {
    final movieDetails = await _movieApi.getMovieDetails(movieId, languageCode);
    return MovieDetails.fromRawMovieDetails(movieDetails);
  }

  Future<List<Movie>> getMoviesPopular(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesPopular =
        await _movieApi.getMoviesPopular(languageCode, pageNumber);
    return moviesPopular.map(Movie.fromRawMovie).toList();
  }

  Future<List<Movie>> getMoviesTopRated(
    String languageCode, {
    int pageNumber = 1,
  }) async {
    final moviesTopRated =
        await _movieApi.getMoviesTopRated(languageCode, pageNumber);
    return moviesTopRated.map(Movie.fromRawMovie).toList();
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
