// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'banner_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerVO _$BannerVOFromJson(Map<String, dynamic> json) => BannerVO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$BannerVOToJson(BannerVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };
