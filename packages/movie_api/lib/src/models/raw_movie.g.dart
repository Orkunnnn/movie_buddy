// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMovie _$RawMovieFromJson(Map<String, dynamic> json) => $checkedCreate(
      'RawMovie',
      json,
      ($checkedConvert) {
        final val = RawMovie(
          $checkedConvert('title', (v) => v as String),
          $checkedConvert('overview', (v) => v as String?),
          $checkedConvert('release_date', (v) => v as String?),
          $checkedConvert('poster_path', (v) => v as String?),
          $checkedConvert('genre_ids',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          $checkedConvert('id', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'releaseDate': 'release_date',
        'posterPath': 'poster_path',
        'genres': 'genre_ids'
      },
    );

Map<String, dynamic> _$RawMovieToJson(RawMovie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPath,
      'genre_ids': instance.genres,
    };
