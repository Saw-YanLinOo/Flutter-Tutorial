// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'date_of_birth')
  String? dateOfBirth;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'profile_photo')
  String? profilePhoto;

  @JsonKey(name: 'active_time')
  String? activeTime;

  UserVO({
    this.id,
    this.userName,
    this.phoneNumber,
    this.email,
    this.password,
    this.dateOfBirth,
    this.gender,
    this.profilePhoto,
    this.activeTime,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);
  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO(id: $id, userName: $userName, phoneNumber: $phoneNumber, password: $password, email: $email, dateOfBirth: $dateOfBirth, gender: $gender, profilePhoto: $profilePhoto)';
  }

  @override
  bool operator ==(covariant UserVO other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userName == userName &&
        other.phoneNumber == phoneNumber &&
        other.password == password &&
        other.email == email &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.profilePhoto == profilePhoto &&
        other.activeTime == activeTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userName.hashCode ^
        phoneNumber.hashCode ^
        password.hashCode ^
        email.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        profilePhoto.hashCode ^
        activeTime.hashCode;
  }
}
