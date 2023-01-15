// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      userName: json['user_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      activeTime: json['active_time'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
      'email': instance.email,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'profile_photo': instance.profilePhoto,
      'active_time': instance.activeTime,
    };
