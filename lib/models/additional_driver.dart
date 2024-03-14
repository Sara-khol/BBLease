
import 'package:json_annotation/json_annotation.dart';

part 'additional_driver.g.dart';

@JsonSerializable()
class AdditionalDriver{

  @JsonKey(name: 'name')
  late String name="";

  @JsonKey(name: 'id_number')
  late String tz='';

  @JsonKey(name: 'license_number')
  late String licenseId='';
  @JsonKey(name: 'license_exp')
  late String licenseExpDate='';
  @JsonKey(name: 'license_date')
  late String licenseIssDate='';
  @JsonKey(name: 'license_level')
  late String licenseDegree='';
  @JsonKey(name: 'is_new_driver')
  bool isNewDriver = false;
  @JsonKey(name: 'is_young_driver')
  bool isYoungDriver = false;

  AdditionalDriver(/*{
    required this.name,
    required this.tz,
    required this.licenseId,
    required this.licenseExpDate,
    required this.licenseIssDate,
    required this.licenseDegree,
    required this.isYoungDriver,
    required this.isNewDriver,
  }*/);


  factory AdditionalDriver.fromJson(Map<String, dynamic> json) => _$AdditionalDriverFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AdditionalDriverToJson(this);
}