import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.movieRepository) : super(MoviesInitial());

  final MovieRepository movieRepository;

  Future<void> fetchMoviesPopular(String languageCode) async {
    try {
      if (state is MoviesInitial) {
        emit(MoviesLoading());
        final moviesPopular =
            await movieRepository.getMoviesPopular(languageCode);
        return emit(MoviesLoaded(movies: moviesPopular));
      } else if (state is MoviesLoaded) {
        final loadedState = state as MoviesLoaded;
        final pageNumber = loadedState.pageNumber + 1;
        final moviesPopular = await movieRepository.getMoviesPopular(
          languageCode,
          pageNumber: pageNumber,
        );
        emit(
          loadedState.copyWith(
            movies: List.of(loadedState.movies)..addAll(moviesPopular),
            pageNumber: pageNumber,
          ),
        );
      }
    } on Exception {
      emit(MoviesFailed());
    }
  }
}
