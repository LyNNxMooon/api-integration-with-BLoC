import 'package:json_annotation/json_annotation.dart';
part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {
  final bool? success;
  final String message;

  LogoutResponse({required this.success, required this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
}
