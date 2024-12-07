import 'package:json_annotation/json_annotation.dart';
part 'user_and_logout_error_response.g.dart';

@JsonSerializable()
class UserAndLogOutErrorResponse {
  final String message;

  UserAndLogOutErrorResponse({required this.message});

  factory UserAndLogOutErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAndLogOutErrorResponseFromJson(json);
}
