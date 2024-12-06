import 'package:json_annotation/json_annotation.dart';
part 'user_error_response.g.dart';

@JsonSerializable()
class UserErrorResponse {
  final String message;

  UserErrorResponse({required this.message});

  factory UserErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$UserErrorResponseFromJson(json);
}
