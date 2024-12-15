// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'cart_item_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemVO _$CartItemVOFromJson(Map<String, dynamic> json) => CartItemVO(
      id: (json['id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      product: CartProductVO.fromJson(json['product'] as Map<String, dynamic>),
      totalPrice: (json['totalPrice'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemVOToJson(CartItemVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'product': instance.product,
      'totalPrice': instance.totalPrice,
    };
