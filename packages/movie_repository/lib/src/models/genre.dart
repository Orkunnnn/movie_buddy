import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';

class Genre extends Equatable {
  const Genre({required this.id, required this.name});

  factory Genre.fromRawGenre(RawGenre genre) {
    return Genre(id: genre.id, name: genre.name);
  }

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
