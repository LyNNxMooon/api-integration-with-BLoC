// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailResponse _$ItemDetailResponseFromJson(Map<String, dynamic> json) =>
    ItemDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ItemVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemDetailResponseToJson(ItemDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
