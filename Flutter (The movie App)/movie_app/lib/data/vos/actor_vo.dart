// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';

import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO, adapterName: 'ActorVOAdapter')
class ActorVO extends BaseActorVO {
  @JsonKey(name: 'id')
  @HiveField(2)
  int? id;

  @JsonKey(name: 'adult')
  @HiveField(3)
  bool? adult;

  @JsonKey(name: 'known_for')
  @HiveField(4)
  List<MovieVO>? knownFor;

  @JsonKey(name: 'popularity')
  @HiveField(5)
  double? popularity;
  
  ActorVO({
    this.adult,
    this.id,
    this.knownFor,
    String? name,
    String? profilePath,
    this.popularity,
  }) : super(
          name: name,
          profilePath: profilePath,
        );

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActorVOToJson(this);
}
