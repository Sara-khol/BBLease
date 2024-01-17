// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = json['customer_id'] as int
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
  ..isNewDriver = json['is_new_driver'] as bool
  ..isYoungDriver =  _checkYoungDriver(json['birth_date'] as String)
  ..tranzilaStatus = json['status_tranzila'] as bool;

 _checkYoungDriver(String bd) {


  // Current time - at this moment
  DateTime today = DateTime.now();

  // List of possible date patterns
  List<String> possibleDatePatterns = ["yyyy-MM-dd", "dd.MM.yyyy"];

  DateTime? birthDateDt;

  // Try parsing the date with different patterns
  for (String datePattern in possibleDatePatterns) {
    try {
      birthDateDt = DateFormat(datePattern).parse(bd);
      break; // Break out of the loop if parsing is successful
    } catch (e) {
      // Parsing failed with the current pattern, try the next one
    }
  }

  if (birthDateDt == null) {
    // Handle the case when none of the patterns successfully parsed the date
    print("Error: Unable to parse the date");
    return false;
  }

  // Parsed date to check
 // DateTime birthDateDt = DateFormat(datePattern).parse(bd);

  // Date to check but moved 18 years ahead
  DateTime adultDate = DateTime(
    birthDateDt.year + 24,
    birthDateDt.month,
    birthDateDt.day,
  );

  return adultDate.isAfter(today) ;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'customer_id': instance.userId,
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
      'is_young_driver': instance.isYoungDriver,
      'status_tranzila': instance.tranzilaStatus,
    };
