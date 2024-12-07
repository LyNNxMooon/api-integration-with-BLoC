// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'login_register_error_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRegisterErrorVO _$LoginRegisterErrorVOFromJson(
        Map<String, dynamic> json) =>
    LoginRegisterErrorVO(
      emailOrPhone: (json['emailOrPhone'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
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

Map<String, dynamic> _$LoginRegisterErrorVOToJson(
        LoginRegisterErrorVO instance) =>
    <String, dynamic>{
      'emailOrPhone': instance.emailOrPhone,
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'fcm_token_key': instance.fcmKey,
    };
