import 'package:json_annotation/json_annotation.dart';

part 'otp_code_vo.g.dart';

@JsonSerializable()
class OtpCodeVO {
  @JsonKey(name: 'code')
  String? code;

  OtpCodeVO({
    this.code,
  });

  factory OtpCodeVO.fromJson(Map<String, dynamic> json) =>
      _$OtpCodeVOFromJson(json);
  Map<String, dynamic> toJson() => _$OtpCodeVOToJson(this);
}
