
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item_vo.g.dart';

@JsonSerializable()
class CartItemVO {
  final int id;
  @JsonKey(name: "customer_id")
  final int customerID;
  final int quantity;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  final ItemVO product;

  factory CartItemVO.fromJson(Map<String, dynamic> json) =>
      _$CartItemVOFromJson(json);

  CartItemVO(
      {required this.id,
      required this.customerID,
      required this.quantity,
      required this.createdAt,
      required this.updatedAt,
      required this.product});
}
