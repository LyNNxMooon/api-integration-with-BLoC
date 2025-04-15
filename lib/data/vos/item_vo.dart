import 'package:json_annotation/json_annotation.dart';
part 'item_vo.g.dart';

@JsonSerializable()
class ItemVO {
  final int id;
  final String name;
  String? barcode;
  @JsonKey(name: "order_index")
  final int orderIndex;
  String? description;
  dynamic brand;
  dynamic category;
  final List? genres;
  final int quantity;
  final String price;
  @JsonKey(name: "discounted_price")
  int? discountedPrice;
  final String status;
  final bool wish;
  @JsonKey(name: "wish_id")
  final bool wishId;
  final dynamic image;
  final String instock;
  @JsonKey(name: "created_at")
  final String createdAt;

  ItemVO(
      {required this.id,
      required this.name,
      required this.barcode,
      required this.orderIndex,
      required this.description,
      required this.brand,
      required this.category,
      required this.genres,
      required this.quantity,
      required this.price,
      required this.discountedPrice,
      required this.status,
      required this.wish,
      required this.wishId,
      required this.image,
      required this.instock,
      required this.createdAt});

  factory ItemVO.fromJson(Map<String, dynamic> json) => _$ItemVOFromJson(json);
}
