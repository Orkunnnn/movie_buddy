import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/movie/helpers/bloc_helpers.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MoviePopularBloc extends Bloc<MovieEvent, MovieState> {
  MoviePopularBloc({
    required this.movieRepository,
    required this.localizationCubit,
  }) : super(const MovieState()) {
    on<MoviesFetched>(
      _onMoviesFetched,
      transformer: throttleDroppable(const Duration(milliseconds: 200)),
    );
    on<MoviesLanguageChanged>(_onMoviesLanguageChanged);
  }

  final MovieRepository movieRepository;
  final LocalizationCubit localizationCubit;

  Future<void> _onMoviesLanguageChanged(
    MoviesLanguageChanged event,
    Emitter<MovieState> emit,
  ) async {
    final languageCode = localizationCubit.state?.languageCode ?? "tr";
    final movies = await movieRepository.getMoviesPopular(languageCode);
    emit(
      state.copyWith(
        hasReachedMax: false,
        pageNumber: 1,
        movies: movies,
        status: MovieStatus.success,
        key: PageStorageKey(state.key.value + 1),
      ),
    );
  }

  Future<void> _onMoviesFetched(
    MoviesFetched event,
    Emitter<MovieState> emit,
  ) async {
    if (state.hasReachedMax) return;
    final languageCode = localizationCubit.state?.languageCode ?? "tr";
    try {
      if (state.status == MovieStatus.initial) {
        final movies = await movieRepository.getMoviesPopular(languageCode);
        return emit(
          state.copyWith(
            hasReachedMax: false,
            pageNumber: 1,
            status: MovieStatus.success,
            movies: movies,
          ),
        );
      }
      final pageNumber = state.pageNumber + 1;
      final movies = await movieRepository.getMoviesPopular(
        languageCode,
        pageNumber: pageNumber,
      );
      final hasReachedMax = state.movies.length >= 100;
      emit(
        state.copyWith(
          movies: Set.of(state.movies)..addAll(movies),
          hasReachedMax: hasReachedMax,
          status: MovieStatus.success,
          pageNumber: pageNumber,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }
}
