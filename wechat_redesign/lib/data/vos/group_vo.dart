// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:wechat_redesign/data/vos/message_vo.dart';

part 'group_vo.g.dart';

@JsonSerializable()
class GroupVO {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'group_photo')
  String? groupPhoto;

  @JsonKey(name: 'ids')
  List<String>? ids;

  // @JsonKey(name: 'messages')
  // List<MessageVO>? messages;

  @JsonKey(name: 'time_stamp')
  String? timeStamp;

  GroupVO({
    this.id,
    this.name,
    this.groupPhoto,
    this.ids,
    // this.messages,
    this.timeStamp,
  });

  factory GroupVO.fromJson(Map<String, dynamic> json) =>
      _$GroupVOFromJson(json);
  Map<String, dynamic> toJson() => _$GroupVOToJson(this);

  @override
  String toString() {
    return 'GroupVO(id: $id, name: $name, groupPhoto: $groupPhoto, ids: $ids, timeStamp: $timeStamp)';
  }
}
