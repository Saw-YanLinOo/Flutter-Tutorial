// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupVO _$GroupVOFromJson(Map<String, dynamic> json) => GroupVO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      groupPhoto: json['group_photo'] as String?,
      ids: (json['ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
      // messages: (json['messages'] as List<dynamic>?)
      //     ?.map((e) => MessageVO.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      timeStamp: json['time_stamp'] as String?,
    );

Map<String, dynamic> _$GroupVOToJson(GroupVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group_photo': instance.groupPhoto,
      'ids': instance.ids,
      // 'messages': instance.messages,
      'time_stamp': instance.timeStamp,
    };
