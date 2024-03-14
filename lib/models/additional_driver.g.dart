// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalDriver _$AdditionalDriverFromJson(Map<String, dynamic> json) =>
    AdditionalDriver()
      ..name = json['name'] as String
      ..tz = json['id_number'] as String
      ..licenseId = json['license_number'] as String
      ..licenseExpDate = json['license_exp'] as String
      ..licenseIssDate = json['license_date'] as String
      ..licenseDegree = json['license_level'] as String
      ..isNewDriver = json['is_new_driver'] as bool
      ..isYoungDriver = json['is_young_driver'] as bool;

Map<String, dynamic> _$AdditionalDriverToJson(AdditionalDriver instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id_number': instance.tz,
      'license_number': instance.licenseId,
      'license_exp': instance.licenseExpDate,
      'license_date': instance.licenseIssDate,
      'license_level': instance.licenseDegree,
      'is_new_driver': instance.isNewDriver,
      'is_young_driver': instance.isYoungDriver,
    };
