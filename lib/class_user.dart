
import 'package:camera/camera.dart';

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


  User._privateConstructor();

  static final User _instance = User._privateConstructor();

  factory User() => _instance;
}