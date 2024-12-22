import 'package:bloc_api/data/vos/banner_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  final bool success;
  final String message;
  final List<BannerVO> data;

  BannerResponse(
      {required this.success, required this.message, required this.data});

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}
