// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_add_and_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartAddAndUpdateResponse _$CartAddAndUpdateResponseFromJson(
        Map<String, dynamic> json) =>
    CartAddAndUpdateResponse(
      id: (json['id'] as num).toInt(),
      customerID: (json['customer_id'] as num).toInt(),
      productID: json['product_id'] as String,
      qauntity: json['qauntity'] as String,
      updatedAt: json['updated_at'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$CartAddAndUpdateResponseToJson(
        CartAddAndUpdateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerID,
      'product_id': instance.productID,
      'qauntity': instance.qauntity,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
    };
