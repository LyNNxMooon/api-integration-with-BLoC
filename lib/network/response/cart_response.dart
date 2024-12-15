import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  final String status;
  final List<CartItemVO> data;
  final int totalPrice;
  final String tax;
  @JsonKey(name: 'tax_amount')
  final int taxAmount;
  @JsonKey(name: 'grand_total')
  final int grandTotal;

  CartResponse(
      {required this.status,
      required this.data,
      required this.totalPrice,
      required this.tax,
      required this.taxAmount,
      required this.grandTotal});

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
}
