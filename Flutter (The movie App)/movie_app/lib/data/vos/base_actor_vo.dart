// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'base_actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BASE_ACTOR_VO, adapterName: 'BaseActorVOAdapter')

class BaseActorVO {
  @JsonKey(name: 'name')
  @HiveField(0)
  String? name;

  @JsonKey(name: 'profile_path')
  @HiveField(1)
  String? profilePath;


  BaseActorVO({
    this.name,
    this.profilePath,
  });

  factory BaseActorVO.fromJson(Map<String, dynamic> json) =>
      _$BaseActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$BaseActorVOToJson(this);
}
