import 'package:bloc_api/data/vos/cart_product_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item_vo.g.dart';

@JsonSerializable()
class CartItemVO {
  final int id;
  final int quantity;
  final CartProductVO product;
  final int totalPrice;

  CartItemVO(
      {required this.id,
      required this.quantity,
      required this.product,
      required this.totalPrice});

  factory CartItemVO.fromJson(Map<String, dynamic> json) =>
      _$CartItemVOFromJson(json);
}
