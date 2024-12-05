// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      imgURL: json['image_url'] as String,
      email: json['email'] as String,
      fcm: json['fcm_token_key'] as String,
      isBanned: json['is_banned'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'image_url': instance.imgURL,
      'email': instance.email,
      'fcm_token_key': instance.fcm,
      'is_banned': instance.isBanned,
      'created_at': instance.createdAt,
    };
