// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CartItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toInt(),
      tax: json['tax'] as String?,
      taxAmount: json['tax_amount'] as num?,
      grandTotal: json['grand_total'] as num?,
    );

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'totalPrice': instance.totalPrice,
      'tax': instance.tax,
      'tax_amount': instance.taxAmount,
      'grand_total': instance.grandTotal,
    };
