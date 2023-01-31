import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_event.dart';
part 'movie_state.dart';

const _throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required this.movieRepository, required this.localizationCubit})
      : super(const MovieState()) {
    on<MoviesFetched>(
      _onMoviesFetched,
      transformer: throttleDroppable(_throttleDuration),
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
          state.copyWith(status: MovieStatus.success, movies: movies),
        );
      }
      final pageNumber = state.pageNumber + 1;
      final hasReachedMax = state.movies.length >= 100;
      final movies = await movieRepository.getMoviesPopular(
        languageCode,
        pageNumber: pageNumber,
      );
      hasReachedMax
          ? emit(
              state.copyWith(
                movies: state.movies,
                hasReachedMax: hasReachedMax,
                status: MovieStatus.success,
                pageNumber: pageNumber,
              ),
            )
          : emit(
              state.copyWith(
                movies: List.of(state.movies)..addAll(movies),
                hasReachedMax: hasReachedMax,
                pageNumber: pageNumber,
                status: MovieStatus.success,
              ),
            );
    } on Exception {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }
}
