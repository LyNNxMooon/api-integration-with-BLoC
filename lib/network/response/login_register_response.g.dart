// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRegisterResponse _$LoginRegisterResponseFromJson(
        Map<String, dynamic> json) =>
    LoginRegisterResponse(
      success: json['success'] as bool,
      token: json['token'] as String,
      data: UserVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginRegisterResponseToJson(
        LoginRegisterResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'data': instance.data,
    };
