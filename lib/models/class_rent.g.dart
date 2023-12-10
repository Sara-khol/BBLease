// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_rent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rental _$RentalFromJson(Map<String, dynamic> json) => Rental(
      DateTime.parse(json['start_date'] as String),
      DateTime.parse(json['end_date'] as String),
      Car.fromJson(json['car'] as Map<String, dynamic>),
      json['insurance'] as int,
      json['limit-km'] as int,
      json['deductible'] as int,
      (json['price'] as num).toDouble(),
      json['url-order-pdf'] as String,
    )..orderNum = json['ID'] as int;

Map<String, dynamic> _$RentalToJson(Rental instance) => <String, dynamic>{
      'ID': instance.orderNum,
      'car': instance.car,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'insurance': instance.insurance,
      'limit-km': instance.limitedKM,
      'deductible': instance.deductible,
      'price': instance.price,
      'url-order-pdf': instance.url,
    };
