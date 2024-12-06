import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final bool success;
  final String message;
  final UserVO data;

  UserResponse(
      {required this.success, required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
