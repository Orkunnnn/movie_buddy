import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/src/models/genre.dart';

class MovieDetails extends Equatable {
  const MovieDetails({
    required this.title,
    required this.overview,
    required this.status,
    required this.tagline,
    required this.releaseDate,
    required this.posterPathFull,
    required this.genres,
  });

  factory MovieDetails.fromRawMovieDetails(RawMovieDetails movieDetails) {
    final posterPathFull =
        "https://image.tmdb.org/t/p/original/${movieDetails.posterPath}";
    return MovieDetails(
      title: movieDetails.title,
      overview: movieDetails.overview,
      status: movieDetails.status,
      tagline: movieDetails.tagline,
      releaseDate: movieDetails.releaseDate,
      posterPathFull: posterPathFull,
      genres: movieDetails.genres.map(Genre.fromRawGenre).toList(),
    );
  }

  final String title;
  final String overview;
  final String status;
  final String tagline;
  final String releaseDate;
  final String posterPathFull;
  final List<Genre> genres;

  @override
  List<Object?> get props =>
      [title, overview, status, tagline, releaseDate, posterPathFull, genres];
}
