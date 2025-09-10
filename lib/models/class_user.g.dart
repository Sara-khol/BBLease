// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = (json['customer_id'] as num).toInt()
  ..firstName = json['name'] as String
  ..lastName = json['family_name'] as String
  ..name = json['doc_name'] as String?
  ..tz = json['id_number'] as String
  ..birthDate = json['birth_date'] as String
  ..email = json['email'] as String
  ..phoneNumber = json['phone_number'] as String
  ..anotherPhone = json['customer_another_phone'] as String
  ..city = json['customer_city'] as String
  ..address = json['customer_address'] as String
  ..getNotification = json['is_approve_get_ads'] as bool
  ..licenseId = json['license_number'] as String
  ..licenseExpDate = json['license_exp'] as String
  ..licenseIssDate = json['license_date'] as String
  ..licenseDegree = json['license_level'] as String
  ..isNewDriver = json['is_new_driver'] as bool
  ..isYoungDriver = json['is_young_driver'] as bool
  ..tranzilaStatus = json['status_tranzila'] as bool
  ..tranzilaCcno = json['tranzila_ccno'] as String
  ..tranzilaCardExpDate = json['tranzila_card_exp_date'] as String
  ..customerStatus = json['customer_status'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'customer_id': instance.userId,
      'name': instance.firstName,
      'family_name': instance.lastName,
      'doc_name': instance.name,
      'id_number': instance.tz,
      'birth_date': instance.birthDate,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'customer_another_phone': instance.anotherPhone,
      'customer_city': instance.city,
      'customer_address': instance.address,
      'is_approve_get_ads': instance.getNotification,
      'license_number': instance.licenseId,
      'license_exp': instance.licenseExpDate,
      'license_date': instance.licenseIssDate,
      'license_level': instance.licenseDegree,
      'is_new_driver': instance.isNewDriver,
      'is_young_driver': instance.isYoungDriver,
      'status_tranzila': instance.tranzilaStatus,
      'tranzila_ccno': instance.tranzilaCcno,
      'tranzila_card_exp_date': instance.tranzilaCardExpDate,
      'customer_status': instance.customerStatus,
    };
