// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genere_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenereResponse _$GenereResponseFromJson(Map<String, dynamic> json) =>
    GenereResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => GenereVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenereResponseToJson(GenereResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
