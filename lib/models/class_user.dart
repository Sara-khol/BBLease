
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class_user.g.dart';

@JsonSerializable()
class User{
 @JsonKey(name: 'customer_id')
 late int userId=-1;
  @JsonKey(name: 'reg_images', toJson: _imagesToJson, fromJson: _imagesFromJson,includeFromJson: false)
  List<XFile?> regImages = List<XFile?>.filled(3, null);

  @JsonKey(name: 'name')
  late String firstName="";
  @JsonKey(name: 'family_name')
  late String lastName='';
  @JsonKey(name: 'doc_name')
  String? name;
  @JsonKey(name: 'id_number')
  late String tz='';
  @JsonKey(name: 'birth_date')
  late String birthDate='';
  late String email='';
  @JsonKey(name: 'phone_number')
  late String phoneNumber='';
  @JsonKey(name: 'is_approve_get_ads')
  bool getNotification=true;


  @JsonKey(name: 'license_number')
  late String licenseId='';
  @JsonKey(name: 'license_exp')
  late String licenseExpDate='';
  @JsonKey(name: 'license_date')
  late String licenseIssDate='';
  @JsonKey(name: 'license_level')
  late String licenseDegree='';
  @JsonKey(name: 'is_new_driver')
  bool isNewDriver=false;
 @JsonKey(name: 'is_young_driver',includeFromJson: false)
 bool isYoungDriver=false;
  @JsonKey(name: 'status_tranzila')
  bool tranzilaStatus=false;

  // void setBirthDate(String dateString) {
  //   try {
  //     birthDate = DateFormat('dd.MM.yyyy').parse(dateString);
  //   } catch (e) {
  //     birthDate = DateFormat('dd.MM.yyyy').parse('01.01.1970');
  //   }
  // }
  //
  // void setLicenseExpDate(String dateString) {
  //   try {
  //     licenseExpDate = DateFormat('dd.MM.yyyy').parse(dateString);
  //   } catch (e) {
  //     licenseExpDate=DateFormat('dd.MM.yyyy').parse('01.01.1970');
  //   }
  // }
  //
  // void setLicenseIssDate(String dateString) {
  //   try {
  //     licenseIssDate = DateFormat('dd.MM.yyyy').parse(dateString);
  //   } catch (e) {
  //     licenseIssDate=DateFormat('dd.MM.yyyy').parse('01.01.1970');
  //   }
  // }

  User._privateConstructor();

  static final User _instance = User._privateConstructor();

  factory User() => _instance;

  static List<String?> _imagesToJson(List<XFile?> images) {
    return images.map((image) => image?.path).toList();
  }

  static List<XFile?> _imagesFromJson(List<dynamic> json) {
    return json.map((path) => XFile(path)).toList();
  }


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);

 void clear() {
  userId = -1;
  regImages = List<XFile?>.filled(3, null);
  firstName = "";
  lastName = "";
  name = null;
  tz = "";
  birthDate = "";
  email = "";
  phoneNumber = "";
  getNotification = true;
  licenseId = "";
  licenseExpDate = "";
  licenseIssDate = "";
  licenseDegree = "";
  isNewDriver = false;
  tranzilaStatus = false;
 }
}