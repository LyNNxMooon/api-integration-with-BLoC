// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemVO _$CartItemVOFromJson(Map<String, dynamic> json) => CartItemVO(
      id: (json['id'] as num).toInt(),
      customerID: (json['customer_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      product: ItemVO.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemVOToJson(CartItemVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerID,
      'quantity': instance.quantity,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'product': instance.product,
    };
