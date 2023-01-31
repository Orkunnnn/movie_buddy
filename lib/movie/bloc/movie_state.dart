part of 'movie_bloc.dart';

enum MovieStatus { initial, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    this.pageNumber = 1,
    this.movies = const [],
    this.hasReachedMax = false,
    this.key = const PageStorageKey(0),
  });

  final MovieStatus status;
  final List<Movie> movies;
  final int pageNumber;
  final bool hasReachedMax;
  final PageStorageKey<int> key;

  @override
  List<Object> get props => [status, movies, hasReachedMax, pageNumber];

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? movies,
    int? pageNumber,
    bool? hasReachedMax,
    PageStorageKey<int>? key,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      pageNumber: pageNumber ?? this.pageNumber,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      key: key ?? this.key,
    );
  }
}
