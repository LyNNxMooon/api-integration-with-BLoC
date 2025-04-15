// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemVO _$ItemVOFromJson(Map<String, dynamic> json) => ItemVO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      barcode: json['barcode'] as String?,
      orderIndex: (json['order_index'] as num).toInt(),
      description: json['description'] as String?,
      brand: json['brand'],
      category: json['category'],
      genres: json['genres'] as List<dynamic>,
      quantity: (json['quantity'] as num).toInt(),
      price: json['price'] as String,
      discountedPrice: (json['discounted_price'] as num?)?.toInt(),
      status: json['status'] as String,
      wish: json['wish'] as bool,
      wishId: json['wish_id'] as bool,
      image: json['image'],
      instock: json['instock'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$ItemVOToJson(ItemVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
      'order_index': instance.orderIndex,
      'description': instance.description,
      'brand': instance.brand,
      'category': instance.category,
      'genres': instance.genres,
      'quantity': instance.quantity,
      'price': instance.price,
      'discounted_price': instance.discountedPrice,
      'status': instance.status,
      'wish': instance.wish,
      'wish_id': instance.wishId,
      'image': instance.image,
      'instock': instance.instock,
      'created_at': instance.createdAt,
    };
