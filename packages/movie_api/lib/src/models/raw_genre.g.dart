// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawGenre _$RawGenreFromJson(Map<String, dynamic> json) => $checkedCreate(
      'RawGenre',
      json,
      ($checkedConvert) {
        final val = RawGenre(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$RawGenreToJson(RawGenre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
