// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: json['ID'] as int,
      carNumber: json['car_number'] as int,
      model: json['model'] as String,
      seats: json['seats_number'] as int,
      doors: json['doors_number'] as int,
      pricePerDay: json['price_per_day'] as int,
      pricePerHour: json['price_per_hour'] as int,
      type: json['car_type'] as String,
      city: json['city'] as String,
      maxFuel: (json['fuel_container_max'] as num).toDouble(),
      address: json['adress'] as String,
    )
      ..carImages =
          (json['car_images'] as List<dynamic>).map((e) => e as String).toList()
      ..parkPosition = (json['park_position'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'ID': instance.id,
      'car_number': instance.carNumber,
      'model': instance.model,
      'seats_number': instance.seats,
      'doors_number': instance.doors,
      'car_images': instance.carImages,
      'park_position': instance.parkPosition,
      'price_per_day': instance.pricePerDay,
      'price_per_hour': instance.pricePerHour,
      'car_type': instance.type,
      'fuel_container_max': instance.maxFuel,
      'city': instance.city,
      'adress': instance.address,
    };
