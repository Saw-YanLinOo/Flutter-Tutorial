// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_now_playing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) =>
    MovieListResponse(
      dates: json['date'] == null
          ? null
          : DateVO.fromJson(json['date'] as Map<String, dynamic>),
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{
      'date': instance.dates,
      'page': instance.page,
      'results': instance.results,
    };
