import 'package:bloc_api/data/vos/register_error_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_error_response.g.dart';

@JsonSerializable()
class RegisterErrorResponse {
  final String message;
  final RegisterErrorVO errors;

  RegisterErrorResponse({required this.message, required this.errors});

  factory RegisterErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterErrorResponseFromJson(json);
}
