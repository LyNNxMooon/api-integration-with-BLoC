import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  final int id;
  final String name;
  final String phone;
  @JsonKey(name: 'image_url')
  final String imgURL;
  final String email;
  @JsonKey(name: 'fcm_token_key')
  final String fcm;
  @JsonKey(name: 'is_banned')
  final String? isBanned;
  @JsonKey(name: 'created_at')
  final String createdAt;

  UserVO(
      {required this.id,
      required this.name,
      required this.phone,
      required this.imgURL,
      required this.email,
      required this.fcm,
      required this.isBanned,
      required this.createdAt});

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);
}
