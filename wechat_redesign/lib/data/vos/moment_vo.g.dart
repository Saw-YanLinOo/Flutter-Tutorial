// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as int?,
      description: json['description'] as String?,
      postImages: (json['post_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profilePicture: json['profile_picture'] as String?,
      userName: json['user_name'] as String?,
      timeStamp: json['time_stamp'] as String?,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'post_images': instance.postImages,
      'profile_picture': instance.profilePicture,
      'user_name': instance.userName,
      'time_stamp': instance.timeStamp,
    };
