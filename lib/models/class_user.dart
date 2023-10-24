
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';

class User{
  List<XFile?> regImages = List<XFile?>.filled(3, null);

  late String firstName;
  late String lastName;
  String? name;
  late String id;
  late DateTime birthDate;
  late String email;
  late String phoneNumber;
  bool getNotification=true;

  late String licenseId;
  late DateTime licenseExpDate;
  late DateTime licenseIssDate;
  late String licenseDegree;
  bool isNewDriver=false;

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
}