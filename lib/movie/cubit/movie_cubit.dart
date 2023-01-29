import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({required this.movieRepository}) : super(const MovieState());

  final MovieRepository movieRepository;

  Future<void> fetchMoviesPopular(String languageCode) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MovieStatus.initial) {
        emit(state.copyWith(isFetching: true));
        final movies = await movieRepository.getMoviesPopular(languageCode);
        emit(
          state.copyWith(
            movies: movies,
            isFetching: false,
            status: MovieStatus.success,
          ),
        );
      }
      emit(state.copyWith(isFetching: true));
      final pageNumber = state.pageNumber + 1;
      final hasReachedMax = state.movies.length > 100;
      final movies = await movieRepository.getMoviesPopular(
        languageCode,
        pageNumber: pageNumber,
      );
      hasReachedMax
          ? emit(
              state.copyWith(
                isFetching: false,
                movies: state.movies,
                hasReachedMax: hasReachedMax,
                status: MovieStatus.success,
              ),
            )
          : emit(
              state.copyWith(
                isFetching: false,
                movies: List.of(state.movies)..addAll(movies),
                pageNumber: pageNumber,
                status: MovieStatus.success,
                hasReachedMax: hasReachedMax,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }
}
