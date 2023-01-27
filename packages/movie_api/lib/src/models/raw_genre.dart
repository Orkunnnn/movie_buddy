import 'package:json_annotation/json_annotation.dart';

part "raw_genre.g.dart";

@JsonSerializable()
class RawGenre {
  RawGenre({required this.id, required this.name});

  factory RawGenre.fromJson(Map<String, dynamic> json) =>
      _$RawGenreFromJson(json);

  final int id;
  final String name;

  Map<String, dynamic> toJson() => _$RawGenreToJson(this);
}
