import 'package:json_annotation/json_annotation.dart';

import 'car.dart';
part 'class_rent.g.dart';

@JsonSerializable()
class Rental{

  @JsonKey(name: 'ID')
  late int orderNum;
  @JsonKey(name: 'car')
  late Car car;
  @JsonKey(name: 'start_date')
  late DateTime startDate;
  @JsonKey(name: 'end_date')
  late DateTime endDate;


  @JsonKey(name: 'insurance')
   late int insurance ;//כולל ביטוח
  @JsonKey(name: 'limit-km')
  late int limitedKM ; //ללא הגבלת קילומטרים
  @JsonKey(name: 'deductible')
  late int deductible;//ללא השתתפות עצמית

  @JsonKey(name: 'price')
  late double price;

  @JsonKey(name: 'url-order-pdf')
  late String url;

  Rental(this.startDate,this.endDate, this.car, this.insurance, this.limitedKM, this.deductible, this.price, this.url);

/*  Rental._privateConstructor();

  static final Rental _instance = Rental._privateConstructor();

  factory Rental() => _instance;*/

  factory Rental.fromJson(Map<String, dynamic> json) => _$RentalFromJson(json);

  Map<String, dynamic> toJson() => _$RentalToJson(this);

}