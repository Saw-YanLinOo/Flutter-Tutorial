import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/actor_vo.dart';

part 'get_actor_response.g.dart';

@JsonSerializable()
class GetActorResponse {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'results')
  List<ActorVO>? results;

  GetActorResponse({this.results});
  factory GetActorResponse.fromJson(Map<String, dynamic> json) =>
      _$GetActorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetActorResponseToJson(this);
}
