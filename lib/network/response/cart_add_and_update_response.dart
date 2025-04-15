import 'package:json_annotation/json_annotation.dart';
part 'cart_add_and_update_response.g.dart';

@JsonSerializable()
class CartAddAndUpdateResponse {
  final int id;
  @JsonKey(name: "customer_id")
  final int customerID;
  @JsonKey(name: "product_id")
  final String productID;
  final String qauntity;
  @JsonKey(name: "updated_at")
  final String updatedAt;
  @JsonKey(name: "created_at")
  final String createdAt;

  factory CartAddAndUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$CartAddAndUpdateResponseFromJson(json);

  CartAddAndUpdateResponse(
      {required this.id,
      required this.customerID,
      required this.productID,
      required this.qauntity,
      required this.updatedAt,
      required this.createdAt});
}
