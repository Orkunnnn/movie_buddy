import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/movie/bloc/movie_popular_bloc.dart';
import 'package:movie_buddy/movie/helpers/bloc_helpers.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieNowPlayingBloc extends Bloc<MovieEvent, MovieState> {
  MovieNowPlayingBloc({
    required MovieRepository movieRepository,
    required LocalizationCubit localizationCubit,
  })  : _movieRepository = movieRepository,
        _localizationCubit = localizationCubit,
        super(const MovieState()) {
    on<MoviesFetched>(
      _onMoviesFetched,
      transformer: throttleDroppable(const Duration(milliseconds: 200)),
    );
    on<MoviesLanguageChanged>(_onMoviesLanguageChanged);
  }

  final MovieRepository _movieRepository;
  final LocalizationCubit _localizationCubit;

  Future<void> _onMoviesLanguageChanged(
    MoviesLanguageChanged event,
    Emitter<MovieState> emit,
  ) async {
    final languageCode = _localizationCubit.state?.languageCode ?? "tr";
    final movies = await _movieRepository.getMoviesNowPlaying(languageCode);
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
    try {
      final languageCode = _localizationCubit.state?.languageCode ?? "tr";
      if (state.status == MovieStatus.initial) {
        final movies = await _movieRepository.getMoviesNowPlaying(languageCode);
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
      final movies = await _movieRepository.getMoviesNowPlaying(
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
