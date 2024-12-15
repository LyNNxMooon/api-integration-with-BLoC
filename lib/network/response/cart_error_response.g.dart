// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'cart_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartErrorResponse _$CartErrorResponseFromJson(Map<String, dynamic> json) =>
    CartErrorResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CartErrorResponseToJson(CartErrorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
