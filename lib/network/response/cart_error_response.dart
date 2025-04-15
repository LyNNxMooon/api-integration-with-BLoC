import 'package:json_annotation/json_annotation.dart';
part 'cart_error_response.g.dart';

@JsonSerializable()
class CartErrorResponse {
  final String message;

  CartErrorResponse({ required this.message});

  factory CartErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$CartErrorResponseFromJson(json);
}
