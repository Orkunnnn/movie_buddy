import 'package:json_annotation/json_annotation.dart';

part "raw_movie_popular.g.dart";

@JsonSerializable()
class RawMoviePopular {
  RawMoviePopular(
    this.title,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.genres,
  );

  factory RawMoviePopular.fromJson(Map<String, dynamic> json) =>
      _$RawMoviePopularFromJson(json);

  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final List<int> genres;

  Map<String, dynamic> toJson() => _$RawMoviePopularToJson(this);
}
