import 'package:json_annotation/json_annotation.dart';
import 'package:movie_api/src/models/raw_genre.dart';

part "raw_movie_details.g.dart";

@JsonSerializable()
class RawMovieDetails {
  RawMovieDetails(
    this.title,
    this.overview,
    this.status,
    this.tagline,
    this.releaseDate,
    this.posterPath,
    this.genres,
    this.voteAverage,
  );

  factory RawMovieDetails.fromJson(Map<String, dynamic> json) =>
      _$RawMovieDetailsFromJson(json);

  final String title;
  final String overview;
  final String status;
  final String tagline;
  final String? releaseDate;
  final String? posterPath;
  final double voteAverage;
  final List<RawGenre> genres;

  Map<String, dynamic> toJson() => _$RawMovieDetailsToJson(this);
}
