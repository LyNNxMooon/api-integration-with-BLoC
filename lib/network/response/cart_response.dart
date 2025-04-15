import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  final List<CartItemVO> data;

  CartResponse({
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
}
