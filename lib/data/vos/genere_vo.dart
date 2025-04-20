import 'package:json_annotation/json_annotation.dart';
part 'genere_vo.g.dart';

@JsonSerializable()
class GenereVo {
  final int id;
  final String name;
  final String image;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final String status;

  GenereVo(
      {required this.id,
      required this.name,
      required this.image,
      required this.createdAt,
      required this.updatedAt,
      required this.status});

  factory GenereVo.fromJson(Map<String, dynamic> json) =>
      _$GenereVoFromJson(json);
}
