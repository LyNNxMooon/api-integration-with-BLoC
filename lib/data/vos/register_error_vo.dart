import 'package:json_annotation/json_annotation.dart';
part 'register_error_vo.g.dart';

@JsonSerializable()
class RegisterErrorVO {
  final List<String>? name;
  final List<String>? phone;
  final List<String>? password;
  @JsonKey(name: 'fcm_token_key')
  final List<String>? fcmKey;

  RegisterErrorVO(
      {required this.name,
      required this.phone,
      required this.password,
      required this.fcmKey});

  factory RegisterErrorVO.fromJson(Map<String, dynamic> json) =>
      _$RegisterErrorVOFromJson(json);
}
