// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'login_register_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRegisterErrorResponse _$LoginRegisterErrorResponseFromJson(
        Map<String, dynamic> json) =>
    LoginRegisterErrorResponse(
      message: json['message'] as String,
      errors: json['errors'] == null
          ? null
          : LoginRegisterErrorVO.fromJson(
              json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginRegisterErrorResponseToJson(
        LoginRegisterErrorResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
    };
