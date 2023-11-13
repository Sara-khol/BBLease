
import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car{
  @JsonKey(name: 'ID')
  late String id;
  @JsonKey(name: 'post_name')
  late String postName;
  @JsonKey(name: 'car_number')
  late String carNumber;
  @JsonKey(name: 'model')
  late String model;
  @JsonKey(name: 'safety_chair')
  late bool safetyChair;
  @JsonKey(name: 'price_per_day')
  late int pricePerDay;
  @JsonKey(name: 'price_per_hour')
  late int pricePerHour;
  @JsonKey(name: 'fuel_status')
  late double fueltatus;
  @JsonKey(name: 'fuel_container_max')
  late double maxFuel;
  @JsonKey(name: 'city')
  late String city;
  @JsonKey(name: 'number_vehicle_chip')
  late String numberVehicleChip;

  Car({
    required this.id,
    required this.carNumber,
    required this.model,
    required this.safetyChair,
    required this.pricePerDay,
    required this.pricePerHour,
    required this.fueltatus,
    required this.city,
    required this.maxFuel,
    required this.numberVehicleChip,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.1
  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CarToJson(this);
}