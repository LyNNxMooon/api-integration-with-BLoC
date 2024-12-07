import 'package:bloc_api/data/vos/login_register_error_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_register_error_response.g.dart';

@JsonSerializable()
class LoginRegisterErrorResponse {
  final String message;
  final LoginRegisterErrorVO errors;

  LoginRegisterErrorResponse({required this.message, required this.errors});

  factory LoginRegisterErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginRegisterErrorResponseFromJson(json);
}
