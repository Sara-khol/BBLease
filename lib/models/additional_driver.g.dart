// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalDriver _$AdditionalDriverFromJson(Map<String, dynamic> json) =>
    AdditionalDriver()
      ..id = json['id'] as String
      ..licenseId = json['license_number'] as String
      ..licenseExpDate = json['license_exp'] as String
      ..licenseIssDate = json['license_date'] as String
      ..licenseDegree = json['license_level'] as String
      ..isNewDriver = json['new_driver'] as bool;

Map<String, dynamic> _$AdditionalDriverToJson(AdditionalDriver instance) =>
    <String, dynamic>{
      'id': instance.id,
      'license_number': instance.licenseId,
      'license_exp': instance.licenseExpDate,
      'license_date': instance.licenseIssDate,
      'license_level': instance.licenseDegree,
      'new_driver': instance.isNewDriver,
    };
