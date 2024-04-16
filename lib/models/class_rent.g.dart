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
  ..status = json['status'] as String?
  ..creationTime = DateTime.parse(json['post_creation_time'] as String)
  ..additions = (json['extras'] as List<dynamic>?)
      ?.map((e) => Addition.fromJson(e as Map<String, dynamic>))
      .toList()
  ..additionalDriver = json['additionalDriver'] == null
      ? null
      : AdditionalDriver.fromJson(
          json['additionalDriver'] as Map<String, dynamic>);

Map<String, dynamic> _$RentalToJson(Rental instance) => <String, dynamic>{
      'ID': instance.orderNum,
      'car': instance.car,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'price': instance.price,
      'url-order-pdf': instance.url,
      'status': instance.status,
      'extras': instance.additions,
      'additionalDriver': instance.additionalDriver,
    };
