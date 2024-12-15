// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'cart_product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProductVO _$CartProductVOFromJson(Map<String, dynamic> json) =>
    CartProductVO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CartProductVOToJson(CartProductVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'photos': instance.photos,
    };
