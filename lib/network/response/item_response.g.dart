// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) => ItemResponse(
      success: json['success'] as bool,
      total: (json['total'] as num).toInt(),
      loadMore: json['can_load_more'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => ItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'total': instance.total,
      'can_load_more': instance.loadMore,
      'data': instance.data,
    };
