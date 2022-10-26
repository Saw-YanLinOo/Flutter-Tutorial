// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'credit_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CREDIT_VO, adapterName: 'CreditVOAdapter')
class CreditVO extends BaseActorVO {
  @JsonKey(name: "adult")
  @HiveField(2)
  bool? adult;

  @JsonKey(name: "gender")
  @HiveField(3)
  int? gender;

  @JsonKey(name: "id")
  @HiveField(4)
  int? id;

  @JsonKey(name: "known_for_department")
  @HiveField(5)
  String? konwnForDepartment;

  // @JsonKey(name: "name")
  // String? name;

  @JsonKey(name: "original_name")
  @HiveField(6)
  String? originalName;

  // @JsonKey(name: "profile_path")
  // String? profilePath;

  @JsonKey(name: "cast_id")
  @HiveField(7)
  int? castId;

  @JsonKey(name: "character")
  @HiveField(8)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(9)
  String? creditId;

  @JsonKey(name: "order")
  @HiveField(10)
  int? order;
  CreditVO({
    this.adult,
    this.gender,
    this.id,
    this.konwnForDepartment,
    String? name,
    this.originalName,
    String? profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  }) : super(
          name: name,
          profilePath: profilePath,
        );

  factory CreditVO.fromJson(Map<String, dynamic> json) =>
      _$CreditVOFromJson(json);

  Map<String, dynamic> toJson() => _$CreditVOToJson(this);

  bool isActor() {
    return konwnForDepartment == KNOWNFORDEPARTMENT;
  }

  bool isCreator() {
    return konwnForDepartment != KNOWNFORDEPARTMENT;
  }
}

const String KNOWNFORDEPARTMENT = 'Acting';
