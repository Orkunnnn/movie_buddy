// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_movie_popular.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMoviePopular _$RawMoviePopularFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RawMoviePopular',
      json,
      ($checkedConvert) {
        final val = RawMoviePopular(
          $checkedConvert('title', (v) => v as String),
          $checkedConvert('overview', (v) => v as String),
          $checkedConvert('release_date', (v) => v as String),
          $checkedConvert('poster_path', (v) => v as String),
          $checkedConvert('genres',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'releaseDate': 'release_date',
        'posterPath': 'poster_path'
      },
    );

Map<String, dynamic> _$RawMoviePopularToJson(RawMoviePopular instance) =>
    <String, dynamic>{
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPath,
      'genres': instance.genres,
    };
