import 'package:json_annotation/json_annotation.dart';

part 'cart_removed_response.g.dart';

@JsonSerializable()
class CartRemovedResponse {
  final String message;

  CartRemovedResponse({required this.message});

  factory CartRemovedResponse.fromJson(Map<String, dynamic> json) =>
      _$CartRemovedResponseFromJson(json);
}
