// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
class MomentVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'post_images')
  List<String>? postImages;

  @JsonKey(name: 'profile_picture')
  String? profilePicture;

  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'time_stamp')
  String? timeStamp;

  MomentVO({
    this.id,
    this.description,
    this.postImages,
    this.profilePicture,
    this.userName,
    this.timeStamp,
  });

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);
  Map<String, dynamic> toJson() => _$MomentVOToJson(this);

  @override
  String toString() {
    return 'MomentVO(id: $id, description: $description, postImages: $postImages, profilePicture: $profilePicture, userName: $userName)';
  }
}
