import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/src/models/genre.dart';

class Movie extends Equatable {
  const Movie({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPathFull,
    required this.genres,
  });

  factory Movie.fromRawMovie(RawMovie movie) {
    final posterPathFull = movie.posterPath ??
        "https://image.tmdb.org/t/p/original/${movie.posterPath}";
    return Movie(
      title: movie.title,
      overview: movie.overview,
      releaseDate: movie.releaseDate ?? "unknown",
      posterPathFull: posterPathFull,
      genres: movie.genres.map((genreId) => genreId.genre).toList(),
    );
  }

  final String title;
  final String overview;
  final String releaseDate;
  final String posterPathFull;
  final List<Genre> genres;

  @override
  List<Object?> get props =>
      [title, overview, releaseDate, posterPathFull, genres];
}

extension on int {
  Genre get genre {
    switch (this) {
      case 28:
        return Genre(id: this, name: "Action");
      case 12:
        return Genre(id: this, name: "Adventure");
      case 16:
        return Genre(id: this, name: "Animation");
      case 35:
        return Genre(id: this, name: "Comedy");
      case 80:
        return Genre(id: this, name: "Crime");
      case 99:
        return Genre(id: this, name: "Documentary");
      case 18:
        return Genre(id: this, name: "Drama");
      case 10751:
        return Genre(id: this, name: "Family");
      case 14:
        return Genre(id: this, name: "Fantasy");
      case 36:
        return Genre(id: this, name: "History");
      case 27:
        return Genre(id: this, name: "Horror");
      case 10402:
        return Genre(id: this, name: "Music");
      case 9648:
        return Genre(id: this, name: "Mystery");
      case 10749:
        return Genre(id: this, name: "Romance");
      case 878:
        return Genre(id: this, name: "Science Fiction");
      case 10770:
        return Genre(id: this, name: "TV Movie");
      case 53:
        return Genre(id: this, name: "Thriller");
      case 10752:
        return Genre(id: this, name: "War");
      case 37:
        return Genre(id: this, name: "Western");
      default:
        return const Genre(id: -1, name: "");
    }
  }
}
