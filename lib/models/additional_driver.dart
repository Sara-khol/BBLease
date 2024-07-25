
import 'package:camera/camera.dart';
import 'package:json_annotation/json_annotation.dart';

part 'additional_driver.g.dart';

@JsonSerializable()
class AdditionalDriver{

  @JsonKey(name: 'id')
  String id="";

  @JsonKey(name: 'license_number')
  String licenseId="";
  @JsonKey(name: 'license_exp')
  late String licenseExpDate='';
  @JsonKey(name: 'license_date')
  late String licenseIssDate=''   ;
  @JsonKey(name: 'license_level')
  String licenseDegree="";
  @JsonKey(name: 'new_driver')
  bool isNewDriver=false;

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

  @override
  String toString(){
    return 'id_number: $id,\nlicense_number: $licenseId ,\nlicense_exp:$licenseExpDate ,\nlicense_date:$licenseIssDate ,\nlicense_level:$licenseDegree ,\nis_new_driver: $isNewDriver,\nimages: ${images[0]?.length()},${images[1]?.length()}';
  }


  factory AdditionalDriver.fromJson(Map<String, dynamic> json) => _$AdditionalDriverFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AdditionalDriverToJson(this);
}