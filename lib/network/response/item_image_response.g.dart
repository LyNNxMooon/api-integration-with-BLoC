// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemImageResponse _$ItemImageResponseFromJson(Map<String, dynamic> json) =>
    ItemImageResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ItemImageVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemImageResponseToJson(ItemImageResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
