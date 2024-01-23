// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_rent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rental _$RentalFromJson(Map<String, dynamic> json) => Rental()
  ..orderNum = json['ID'] as int?
  ..car = Car.fromJson(json['car'] as Map<String, dynamic>)
  ..startDate = DateTime.parse(json['start_date'] as String)
  ..endDate = DateTime.parse(json['end_date'] as String)
  ..price = (json['price'] as num).toDouble()
  ..url = json['url-order-pdf'] as String?
  ..status = json['status'] as String?;

Map<String, dynamic> _$RentalToJson(Rental instance) => <String, dynamic>{
      'ID': instance.orderNum,
      'car': instance.car,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'price': instance.price,
      'url-order-pdf': instance.url,
      'status': instance.status,
    };
