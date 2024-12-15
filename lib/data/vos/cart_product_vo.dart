import 'package:json_annotation/json_annotation.dart';
part 'cart_product_vo.g.dart';

@JsonSerializable()
class CartProductVO {
  final int id;
  final String name;
  final int price;
  final List<String> photos;

  CartProductVO(
      {required this.id,
      required this.name,
      required this.price,
      required this.photos});

  factory CartProductVO.fromJson(Map<String, dynamic> json) =>
      _$CartProductVOFromJson(json);
}
