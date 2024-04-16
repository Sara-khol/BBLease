
import 'package:camera/camera.dart';
import 'package:json_annotation/json_annotation.dart';

part 'additional_driver.g.dart';

@JsonSerializable()
class AdditionalDriver{

  @JsonKey(name: 'name')
  late String name;

  @JsonKey(name: 'mz')
  late String tz;

  @JsonKey(name: 'license_number')
  late String licenseId;
  @JsonKey(name: 'validity')
  late String licenseExpDate;
  @JsonKey(name: 'date_of_issue')
  late String licenseIssDate;
  @JsonKey(name: 'license_level')
  late String licenseDegree;
  @JsonKey(name: 'new_driver')
  late bool isNewDriver;
  @JsonKey(name: 'young_driver')
  late bool isYoungDriver;

  @JsonKey(includeToJson: false, includeFromJson: false)
  List<XFile?> images = List<XFile?>.filled(2, null);

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