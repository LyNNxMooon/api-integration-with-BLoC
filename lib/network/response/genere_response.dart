import 'package:bloc_api/data/vos/genere_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'genere_response.g.dart';

@JsonSerializable()
class GenereResponse {
  final bool success;
  final String message;
  final List<GenereVo> data;

  GenereResponse({required this.success, required this.message, required this.data});

  
  factory GenereResponse.fromJson(Map<String, dynamic> json) =>
      _$GenereResponseFromJson(json);
}