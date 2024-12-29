import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_detail_response.g.dart';

@JsonSerializable()
class ItemDetailResponse {
  final bool success;
  final String message;
  final ItemVO data;

  ItemDetailResponse(
      {required this.success, required this.message, required this.data});

  factory ItemDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailResponseFromJson(json);
}
