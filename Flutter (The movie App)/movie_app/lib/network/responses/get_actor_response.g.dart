// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_actor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetActorResponse _$GetActorResponseFromJson(Map<String, dynamic> json) =>
    GetActorResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..code = json['code'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetActorResponseToJson(GetActorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'results': instance.results,
    };
