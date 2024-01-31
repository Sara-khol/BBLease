import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'additions.dart';
import 'car.dart';
part 'class_rent.g.dart';

@JsonSerializable()
class Rental{

  @JsonKey(name: 'ID')
  int? orderNum;
  @JsonKey(name: 'car')
  late Car car;
  @JsonKey(name: 'start_date')
  late DateTime startDate;
  @JsonKey(name: 'end_date')
  late DateTime endDate;


  @JsonKey(name: 'price')
  late double price;

  @JsonKey(name: 'url-order-pdf')
  String? url;

  @JsonKey(name: 'status')
  String? status;


 //@JsonKey(includeFromJson: false)
 @JsonKey(name: 'extras')
   List<Addition>? additions=[];

  @JsonKey(includeFromJson: false)
  int dayPart=1;


  //Rental(this.startDate,this.endDate, this.car, this.insurance, this.limitedKM, this.deductible, this.price, this.url);
  Rental();
   /*void addRental(DateTime startDate,DateTime endDate,Car car,bool insurance,int limitedKM,bool deductible, double price){
     this.startDate;
     this.endDate;
     this.car;
     this.insurance;
     this.limitedKM;
     this.deductible;
     this.price;
   }*/

/*  Rental._privateConstructor();

  static final Rental _instance = Rental._privateConstructor();

  factory Rental() => _instance;*/

  factory Rental.fromJson(Map<String, dynamic> json) => _$RentalFromJson(json);

  Map<String, dynamic> toJson() => _$RentalToJson(this);

}