part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent {}

class MovieDetailsFetched extends MovieDetailsEvent {
  MovieDetailsFetched(this.movieId);

  final int movieId;
}
