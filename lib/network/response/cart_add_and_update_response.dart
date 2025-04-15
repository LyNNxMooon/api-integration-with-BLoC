import 'package:json_annotation/json_annotation.dart';
part 'cart_add_and_update_response.g.dart';

@JsonSerializable()
class CartAddAndUpdateResponse {
  final int id;
  @JsonKey(name: "customer_id")
  final dynamic customerID;
  @JsonKey(name: "product_id")
  final dynamic productID;
  final dynamic qauntity;
  @JsonKey(name: "updated_at")
  final dynamic updatedAt;
  @JsonKey(name: "created_at")
  final dynamic createdAt;

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
