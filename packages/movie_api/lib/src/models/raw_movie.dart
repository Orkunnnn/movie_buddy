import 'package:json_annotation/json_annotation.dart';

part "raw_movie.g.dart";

@JsonSerializable()
class RawMovie {
  RawMovie(
    this.title,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.genres,
  );

  factory RawMovie.fromJson(Map<String, dynamic> json) =>
      _$RawMovieFromJson(json);

  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  @JsonKey(name: "genre_ids")
  final List<int> genres;

  Map<String, dynamic> toJson() => _$RawMovieToJson(this);
}
