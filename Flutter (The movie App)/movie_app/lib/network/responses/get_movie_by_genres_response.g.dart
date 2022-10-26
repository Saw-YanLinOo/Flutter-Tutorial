// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movie_by_genres_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMovieByGenreResponse _$GetMovieByGenreResponseFromJson(
        Map<String, dynamic> json) =>
    GetMovieByGenreResponse(
      (json['results'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMovieByGenreResponseToJson(
        GetMovieByGenreResponse instance) =>
    <String, dynamic>{
      'results': instance.items,
    };
