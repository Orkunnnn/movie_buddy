import 'package:json_annotation/json_annotation.dart';

part "raw_genre.g.dart";

@JsonSerializable()
class Genre {
  Genre(this.id, this.name);

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  final int id;
  final String name;

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
