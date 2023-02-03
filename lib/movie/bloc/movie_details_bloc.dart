import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc({
    required this.movieRepository,
    required this.localizationCubit,
  }) : super(const MovieDetailsState()) {
    on<MovieDetailsFetched>(
      (event, emit) => _onMovieDetailsFetched(event, emit, event.movieId),
    );
  }

  final MovieRepository movieRepository;
  final LocalizationCubit localizationCubit;

  Future<void> _onMovieDetailsFetched(
    MovieDetailsFetched event,
    Emitter<MovieDetailsState> emit,
    int movieId,
  ) async {
    try {
      emit(state.copyWith(movieStatus: MovieStatus.initial));
      final movieDetails = await movieRepository.getMovieDetails(
        movieId,
        localizationCubit.state?.languageCode ?? "tr",
      );
      emit(
        state.copyWith(
          movieStatus: MovieStatus.success,
          movieDetails: movieDetails,
        ),
      );
    } on Exception {
      emit(state.copyWith(movieStatus: MovieStatus.failure));
    }
  }
}
