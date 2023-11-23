
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class_user.g.dart';

@JsonSerializable()
class User{

  @JsonKey(name: 'reg_images', toJson: _imagesToJson, fromJson: _imagesFromJson)
  List<XFile?> regImages = List<XFile?>.filled(3, null);

  @JsonKey(name: 'first_name')
  late String firstName="";
  @JsonKey(name: 'last_name')
  late String lastName;
  String? name;
  @JsonKey(name: 'ID')
  late String id;
  @JsonKey(name: 'birth_date')
  late DateTime birthDate;
  late String email;
  @JsonKey(name: 'phone_number')
  late String phoneNumber;
  @JsonKey(name: 'get_notifications')
  bool getNotification=true;


  @JsonKey(name: 'license_id')
  late String licenseId;
  late DateTime licenseExpDate;
  late DateTime licenseIssDate;
  late String licenseDegree;
  bool isNewDriver=false;

late String password;

  void setBirthDate(String dateString) {
    try {
      birthDate = DateFormat('dd.MM.yyyy').parse(dateString);
    } catch (e) {
      birthDate = DateFormat('dd.MM.yyyy').parse('01.01.1970');
    }
  }

  void setLicenseExpDate(String dateString) {
    try {
      licenseExpDate = DateFormat('dd.MM.yyyy').parse(dateString);
    } catch (e) {
      licenseExpDate=DateFormat('dd.MM.yyyy').parse('01.01.1970');
    }
  }

  void setLicenseIssDate(String dateString) {
    try {
      licenseIssDate = DateFormat('dd.MM.yyyy').parse(dateString);
    } catch (e) {
      licenseIssDate=DateFormat('dd.MM.yyyy').parse('01.01.1970');
    }
  }

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
}