import 'package:json_annotation/json_annotation.dart';
part 'cart_add_update_and_remove_response.g.dart';

@JsonSerializable()
class CartAddUpdateAndRemoveResponse {
  final String status;
  dynamic data;

  CartAddUpdateAndRemoveResponse({required this.status, required this.data});

  factory CartAddUpdateAndRemoveResponse.fromJson(Map<String, dynamic> json) =>
      _$CartAddUpdateAndRemoveResponseFromJson(json);
}
