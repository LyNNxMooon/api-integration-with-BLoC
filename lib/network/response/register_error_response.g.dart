// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterErrorResponse _$RegisterErrorResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterErrorResponse(
      message: json['message'] as String,
      errors: RegisterErrorVO.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterErrorResponseToJson(
        RegisterErrorResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
    };
