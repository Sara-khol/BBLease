// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: json['ID'] as String,
      carNumber: json['car_number'] as String,
      model: json['model'] as String,
      safetyChair: json['safety_chair'] as bool,
      pricePerDay: json['price_per_day'] as int,
      pricePerHour: json['price_per_hour'] as int,
      fueltatus: (json['fuel_status'] as num).toDouble(),
      city: json['city'] as String,
      maxFuel: (json['fuel_container_max'] as num).toDouble(),
      numberVehicleChip: json['number_vehicle_chip'] as String,
    )..postName = json['post_name'] as String;

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'ID': instance.id,
      'post_name': instance.postName,
      'car_number': instance.carNumber,
      'model': instance.model,
      'safety_chair': instance.safetyChair,
      'price_per_day': instance.pricePerDay,
      'price_per_hour': instance.pricePerHour,
      'fuel_status': instance.fueltatus,
      'fuel_container_max': instance.maxFuel,
      'city': instance.city,
      'number_vehicle_chip': instance.numberVehicleChip,
    };
