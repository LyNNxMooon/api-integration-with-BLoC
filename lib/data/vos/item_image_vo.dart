import 'package:json_annotation/json_annotation.dart';
part 'item_image_vo.g.dart';

@JsonSerializable()
class ItemImageVO {
  final int id;
  final String image;

  ItemImageVO({required this.id, required this.image});

  factory ItemImageVO.fromJson(Map<String, dynamic> json) =>
      _$ItemImageVOFromJson(json);
}
