import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final bool success;
  final String token;
  final UserVO data;

  RegisterResponse(
      {required this.success, required this.token, required this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
