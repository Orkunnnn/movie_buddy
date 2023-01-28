// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MovieState {}

class MoviesLoading extends MovieState {}

class MoviesLanguageChanged extends MovieState {
  const MoviesLanguageChanged();
}

class MoviesLoaded extends MovieState {
  const MoviesLoaded({required this.movies, this.pageNumber = 1});

  final int pageNumber;
  final List<Movie> movies;

  @override
  List<Object> get props => [movies, pageNumber];

  MoviesLoaded copyWith({
    int? pageNumber,
    List<Movie>? movies,
  }) {
    return MoviesLoaded(
      pageNumber: pageNumber ?? this.pageNumber,
      movies: movies ?? this.movies,
    );
  }
}

class MoviesFailed extends MovieState {}
