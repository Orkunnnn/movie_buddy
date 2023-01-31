part of 'movie_bloc.dart';

abstract class MovieEvent {}

class MoviesLanguageChanged extends MovieEvent {}

class MoviesFetched extends MovieEvent {}
