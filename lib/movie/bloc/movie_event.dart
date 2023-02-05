part of 'movie_popular_bloc.dart';

abstract class MovieEvent {}

class MoviesLanguageChanged extends MovieEvent {}

class MoviesFetched extends MovieEvent {}
