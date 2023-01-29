import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required this.movieRepository, required this.languageCode})
      : super(const MovieState()) {
    on<MovieFetched>(
      (event, emit) => _onMovieFetched(
        event,
        emit,
        languageCode,
      ),
    );
  }
  final MovieRepository movieRepository;
  final String languageCode;

  Future<void> _onMovieFetched(
    MovieFetched event,
    Emitter<MovieState> emit,
    String languageCode,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MovieStatus.initial) {
        emit(state.copyWith(isFetching: true));
        final movies = await movieRepository.getMoviesPopular(languageCode);
        return emit(
          state.copyWith(
            isFetching: false,
            movies: movies,
            status: MovieStatus.success,
          ),
        );
      }
      final pageNumber = state.pageNumber + 1;
      final hasReachedMax = state.movies.length > 100;
      final movies = await movieRepository.getMoviesPopular(languageCode);
      hasReachedMax
          ? emit(state.copyWith(hasReachedMax: hasReachedMax))
          : emit(
              state.copyWith(
                pageNumber: pageNumber,
                status: MovieStatus.success,
                movies: List.of(state.movies)..addAll(movies),
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }
}
