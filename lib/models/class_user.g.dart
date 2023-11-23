// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..regImages = User._imagesFromJson(json['reg_images'] as List)
  ..firstName = json['first_name'] as String
  ..lastName = json['last_name'] as String
  ..name = json['name'] as String?
  ..id = json['ID'] as String
  ..birthDate = DateTime.parse(json['birth_date'] as String)
  ..email = json['email'] as String
  ..phoneNumber = json['phone_number'] as String
  ..getNotification = json['get_notifications'] as bool
  ..licenseId = json['license_id'] as String
  ..licenseExpDate = DateTime.parse(json['licenseExpDate'] as String)
  ..licenseIssDate = DateTime.parse(json['licenseIssDate'] as String)
  ..licenseDegree = json['licenseDegree'] as String
  ..isNewDriver = json['isNewDriver'] as bool
  ..password = json['password'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'reg_images': User._imagesToJson(instance.regImages),
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'name': instance.name,
      'ID': instance.id,
      'birth_date': instance.birthDate.toIso8601String(),
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'get_notifications': instance.getNotification,
      'license_id': instance.licenseId,
      'licenseExpDate': instance.licenseExpDate.toIso8601String(),
      'licenseIssDate': instance.licenseIssDate.toIso8601String(),
      'licenseDegree': instance.licenseDegree,
      'isNewDriver': instance.isNewDriver,
      'password': instance.password,
    };
