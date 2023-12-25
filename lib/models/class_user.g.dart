// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = json['customer_id'] as int
 // ..regImages = User._imagesFromJson(json['reg_images'] as List)
  ..firstName = json['name'] as String
  ..lastName = json['family_name'] as String
  ..name = json['doc_name'] as String?
  ..tz = json['id_number'] as String
  ..birthDate = json['birth_date'] as String
  ..email = json['email'] as String
  ..phoneNumber = json['phone_number'] as String
  ..getNotification = json['is_approve_get_ads'] as bool
  ..licenseId = json['license_number'] as String
  ..licenseExpDate = json['license_exp'] as String
  ..licenseIssDate = json['license_date'] as String
  ..licenseDegree = json['license_level'] as String
  ..isNewDriver = json['is_new_driver'] as bool;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'customer_id': instance.userId,
      'reg_images': User._imagesToJson(instance.regImages),
      'name': instance.firstName,
      'family_name': instance.lastName,
      'doc_name': instance.name,
      'id_number': instance.tz,
      'birth_date': instance.birthDate,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'is_approve_get_ads': instance.getNotification,
      'license_number': instance.licenseId,
      'license_exp': instance.licenseExpDate,
      'license_date': instance.licenseIssDate,
      'license_level': instance.licenseDegree,
      'is_new_driver': instance.isNewDriver,
    };
