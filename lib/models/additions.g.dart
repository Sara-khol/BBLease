// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Addition _$AdditionFromJson(Map<String, dynamic> json) => Addition(
      title: json['name'] as String,
      name: json['key'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$AdditionToJson(Addition instance) => <String, dynamic>{
      'name': instance.title,
      'key': instance.name,
      'price': instance.price,
    };
