import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_register_response.g.dart';

@JsonSerializable()
class LoginRegisterResponse {
  final bool success;
  final String token;
  UserVO data;

  LoginRegisterResponse(
      {required this.success, required this.token, required this.data});

  factory LoginRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginRegisterResponseFromJson(json);
}
