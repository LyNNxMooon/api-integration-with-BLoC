import 'package:json_annotation/json_annotation.dart';
part 'banner_vo.g.dart';

@JsonSerializable()
class BannerVO {
  final int id;
  final String title;
  final String image;

  BannerVO({required this.id, required this.title, required this.image});

  factory BannerVO.fromJson(Map<String, dynamic> json) =>
      _$BannerVOFromJson(json);
}
