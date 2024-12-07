import 'package:json_annotation/json_annotation.dart';
part 'login_register_error_vo.g.dart';

@JsonSerializable()
class LoginRegisterErrorVO {
  final List<String>? emailOrPhone;
  final List<String>? name;
  final List<String>? phone;
  final List<String>? password;
  @JsonKey(name: 'fcm_token_key')
  final List<String>? fcmKey;

  LoginRegisterErrorVO(
      {required this.emailOrPhone,
      required this.name,
      required this.phone,
      required this.password,
      required this.fcmKey});

  factory LoginRegisterErrorVO.fromJson(Map<String, dynamic> json) =>
      _$LoginRegisterErrorVOFromJson(json);
}
