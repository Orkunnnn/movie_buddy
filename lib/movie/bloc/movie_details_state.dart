part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState({
    this.movieStatus = MovieStatus.initial,
    this.movieDetails,
  });

  final MovieStatus movieStatus;
  final MovieDetails? movieDetails;

  @override
  List<Object?> get props => [movieDetails, movieStatus];

  MovieDetailsState copyWith({
    MovieStatus? movieStatus,
    MovieDetails? movieDetails,
  }) {
    return MovieDetailsState(
      movieStatus: movieStatus ?? this.movieStatus,
      movieDetails: movieDetails ?? this.movieDetails,
    );
  }
}
