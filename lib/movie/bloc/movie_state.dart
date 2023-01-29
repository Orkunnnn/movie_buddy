part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    this.pageNumber = 1,
    this.movies = const [],
    this.hasReachedMax = false,
    this.isFetching = false,
  });

  final MovieStatus status;
  final int pageNumber;
  final List<Movie> movies;
  final bool hasReachedMax;
  final bool isFetching;

  @override
  List<Object> get props => [status, movies, hasReachedMax, isFetching];

  MovieState copyWith({
    MovieStatus? status,
    int? pageNumber,
    List<Movie>? movies,
    bool? hasReachedMax,
    bool? isFetching,
  }) {
    return MovieState(
      status: status ?? this.status,
      pageNumber: pageNumber ?? this.pageNumber,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
