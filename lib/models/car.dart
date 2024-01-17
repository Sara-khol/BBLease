
import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car{
  @JsonKey(name: 'ID')
  late int id;
  /*@JsonKey(name: 'post_name')
  late String postName;*/
  @JsonKey(name: 'car_number')
  late int carNumber;
  @JsonKey(name: 'model')
  late String model;
  @JsonKey(name: 'seats_number')
  late int seats;
  @JsonKey(name: 'doors_number')
  late int doors;
  @JsonKey(name: 'car_images')
  late List<String> carImages;

  /*@JsonKey(name: 'safety_chair')
  bool safetyChair=false;*/
  @JsonKey(name: 'car_images')
  late List<String> carImages;

  @JsonKey(name: 'park_position')
  late Map<String,double> parkPosition;


  @JsonKey(name: 'price_per_day')
  late int pricePerDay;
  @JsonKey(name: 'price_per_hour')
  late int pricePerHour;
  @JsonKey(name: 'car_type')
  late String type;
  /*@JsonKey(name: 'auto_geer')
  late bool autoGeer;*/
 /* @JsonKey(name: 'fuel_status')
  late double fuelStatus;*/
  @JsonKey(name: 'fuel_container_max')
  late double maxFuel;
  @JsonKey(name: 'city')
  late String city;
  /*@JsonKey(name: 'number_vehicle_chip')
  late String numberVehicleChip;*/


  Car({
    required this.id,
    required this.carNumber,
    required this.model,
    required this.seats,
    required this.doors,
    //required this.safetyChair,
    required this.pricePerDay,
    required this.pricePerHour,
    required this.type,
    //required this.autoGeer,
    //required this.fuelStatus,
    required this.city,
    required this.maxFuel,
    //required this.numberVehicleChip,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.1
  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CarToJson(this);
}

enum carType{mini,hybrid,family,VIP}