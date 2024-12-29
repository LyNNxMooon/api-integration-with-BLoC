import 'package:bloc_api/data/vos/item_image_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_image_response.g.dart';

@JsonSerializable()
class ItemImageResponse {
  final bool success;
  final String message;
  final List<ItemImageVO> data;

  ItemImageResponse(
      {required this.success, required this.message, required this.data});

  factory ItemImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemImageResponseFromJson(json);
}
