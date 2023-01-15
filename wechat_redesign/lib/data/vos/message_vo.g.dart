// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      id: json['id'] as String?,
      timeStamp: json['time_stamp'] as String?,
      userName: json['user_name'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      message: json['mssage'] as String?,
      file: json['file'] as String?,
      fileType: json['file_type'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'id': instance.id,
      'time_stamp': instance.timeStamp,
      'user_name': instance.userName,
      'profile_photo': instance.profilePhoto,
      'mssage': instance.message,
      'file': instance.file,
      'file_type': instance.fileType,
      'user_id': instance.userId,
    };
