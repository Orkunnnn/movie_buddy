// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_movie_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMovieDetails _$RawMovieDetailsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RawMovieDetails',
      json,
      ($checkedConvert) {
        final val = RawMovieDetails(
          $checkedConvert('title', (v) => v as String),
          $checkedConvert('overview', (v) => v as String),
          $checkedConvert('status', (v) => v as String),
          $checkedConvert('tagline', (v) => v as String),
          $checkedConvert('release_date', (v) => v as String?),
          $checkedConvert('poster_path', (v) => v as String?),
          $checkedConvert(
              'genres',
              (v) => (v as List<dynamic>)
                  .map((e) => RawGenre.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('vote_average', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'releaseDate': 'release_date',
        'posterPath': 'poster_path',
        'voteAverage': 'vote_average'
      },
    );

Map<String, dynamic> _$RawMovieDetailsToJson(RawMovieDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'overview': instance.overview,
      'status': instance.status,
      'tagline': instance.tagline,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'genres': instance.genres,
    };
