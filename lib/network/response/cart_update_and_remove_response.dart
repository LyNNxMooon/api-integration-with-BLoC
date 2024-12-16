import 'package:json_annotation/json_annotation.dart';
part 'cart_update_and_remove_response.g.dart';

@JsonSerializable()
class CartUpdateAndRemoveResponse {
  final String status;
  dynamic data;

  CartUpdateAndRemoveResponse({required this.status, required this.data});

  factory CartUpdateAndRemoveResponse.fromJson(Map<String, dynamic> json) =>
      _$CartUpdateAndRemoveResponseFromJson(json);
}
