// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genere_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenereVo _$GenereVoFromJson(Map<String, dynamic> json) => GenereVo(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$GenereVoToJson(GenereVo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'status': instance.status,
    };
