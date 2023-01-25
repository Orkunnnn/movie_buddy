// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genre _$GenreFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Genre',
      json,
      ($checkedConvert) {
        final val = Genre(
          $checkedConvert('id', (v) => v as int),
          $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
