// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalDriver _$AdditionalDriverFromJson(Map<String, dynamic> json) =>
    AdditionalDriver()
      ..name = json['name'] as String
      ..tz = json['mz'] as String
      ..licenseId = json['license_number'] as String
      ..licenseExpDate = json['validity'] as String
      ..licenseIssDate = json['date_of_issue'] as String
      ..licenseDegree = json['license_level'] as String
      ..isNewDriver = json['new_driver'] as bool
      ..isYoungDriver = json['young_driver'] as bool;

Map<String, dynamic> _$AdditionalDriverToJson(AdditionalDriver instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mz': instance.tz,
      'license_number': instance.licenseId,
      'validity': instance.licenseExpDate,
      'date_of_issue': instance.licenseIssDate,
      'license_level': instance.licenseDegree,
      'new_driver': instance.isNewDriver,
      'young_driver': instance.isYoungDriver,
    };
