import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "time_stamp")
  String? timeStamp;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "profile_photo")
  String? profilePhoto;

  @JsonKey(name: "mssage")
  String? message;

  @JsonKey(name: "mssage_type")
  String? messageType;

  @JsonKey(name: "file")
  String? file;

  @JsonKey(name: "file_type")
  String? fileType;

  @JsonKey(name: "user_id")
  String? userId;

  MessageVO({
    this.id,
    this.timeStamp,
    this.userName,
    this.profilePhoto,
    this.message,
    this.messageType,
    this.file,
    this.fileType,
    this.userId,
  });

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);

  @override
  String toString() {
    return 'MessageVO(id: $id, timeStamp: $timeStamp, userName: $userName, profilePhoto: $profilePhoto, message: $message, file: $file, fileType: $fileType)';
  }
}
