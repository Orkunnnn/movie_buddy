import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieTopRatedBloc extends Bloc<MovieEvent, MovieState> {
  MovieTopRatedBloc({
    required this.movieRepository,
    required this.localizationCubit,
  }) : super(const MovieState()) {
    on<MoviesFetched>(_onMoviesFetched);
    on<MoviesLanguageChanged>(_onMoviesLanguageChanged);
  }

  final MovieRepository movieRepository;
  final LocalizationCubit localizationCubit;

  Future<void> _onMoviesLanguageChanged(
    MoviesLanguageChanged event,
    Emitter<MovieState> emit,
  ) async {
    final languageCode = localizationCubit.state?.languageCode ?? "tr";
    final movies = await movieRepository.getMoviesTopRated(languageCode);
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
        final movies = await movieRepository.getMoviesTopRated(languageCode);
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
      final movies = await movieRepository.getMoviesTopRated(
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
