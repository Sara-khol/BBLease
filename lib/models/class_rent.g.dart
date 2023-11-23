// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_rent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rental _$RentalFromJson(Map<String, dynamic> json) => Rental()
  ..car = Car.fromJson(json['car'] as Map<String, dynamic>)
  ..startDate = DateTime.parse(json['startDate'] as String)
  ..endDate = DateTime.parse(json['endDate'] as String)
  ..include = Map<String, bool>.from(json['include'] as Map)
  ..code = json['code'] as String
  ..price = (json['price'] as num).toDouble();

Map<String, dynamic> _$RentalToJson(Rental instance) => <String, dynamic>{
      'car': instance.car,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'include': instance.include,
      'code': instance.code,
      'price': instance.price,
    };
