import 'package:json_annotation/json_annotation.dart';

import 'car.dart';
part 'class_rent.g.dart';

@JsonSerializable()
class Rental{
  //@JsonKey(name: 'ID')
  late Car car;

  late DateTime startDate;
  late DateTime endDate;

   Map<String,bool> include={
     'insurance':true, //כולל ביטוח
     'limitedKM':false, //ללא הגבלת קילומטרים
     'deductible':false //ללא השתתפות עצמית
   };

  late String code;

  late double price;


  Rental._privateConstructor();

  static final Rental _instance = Rental._privateConstructor();

  factory Rental() => _instance;

  factory Rental.fromJson(Map<String, dynamic> json) => _$RentalFromJson(json);

  Map<String, dynamic> toJson() => _$RentalToJson(this);

}