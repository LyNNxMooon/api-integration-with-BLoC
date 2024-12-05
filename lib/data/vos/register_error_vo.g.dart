// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_error_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterErrorVO _$RegisterErrorVOFromJson(Map<String, dynamic> json) =>
    RegisterErrorVO(
      name: (json['name'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fcmKey: (json['fcm_token_key'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RegisterErrorVOToJson(RegisterErrorVO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'fcm_token_key': instance.fcmKey,
    };
