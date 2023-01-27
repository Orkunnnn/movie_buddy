import 'package:mocktail/mocktail.dart';

import '../src/movie_repository_test.dart';

MockRawMovieDetails getMockRawMovieDetails() {
  final rawMovieDetails = MockRawMovieDetails();
  when(
    () => rawMovieDetails.title,
  ).thenReturn("title");
  when(
    () => rawMovieDetails.overview,
  ).thenReturn("overview");
  when(
    () => rawMovieDetails.tagline,
  ).thenReturn("tagline");
  when(
    () => rawMovieDetails.status,
  ).thenReturn("status");
  when(
    () => rawMovieDetails.posterPath,
  ).thenReturn("posterPath");
  when(
    () => rawMovieDetails.genres,
  ).thenReturn([]);
  when(
    () => rawMovieDetails.releaseDate,
  ).thenReturn("releaseDate");
  return rawMovieDetails;
}

MockRawMovie getMockRawMovie() {
  final rawMovie = MockRawMovie();
  when(
    () => rawMovie.title,
  ).thenReturn("title");
  when(
    () => rawMovie.overview,
  ).thenReturn("overview");
  when(
    () => rawMovie.releaseDate,
  ).thenReturn("releaseDate");
  when(
    () => rawMovie.posterPath,
  ).thenReturn("posterPath");
  when(
    () => rawMovie.genres,
  ).thenReturn([]);
  return rawMovie;
}
