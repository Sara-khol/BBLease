import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../models/class_user.dart';
import 'package:intl/intl.dart' as intl;
class ApiService {
  final Dio _dio = Dio();
  // final _baseUrl = 'https://bibilease.co.il/?rest_route=/';
  late String _baseUrl;
  //String devURL='https://bibilease.quicksolutions.co.il/wp-json/';

  ApiService._privateConstructor(){
    if(!kIsWeb) {
      _dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          // Don't trust any certificate just because their root cert is trusted.
          final HttpClient client =
          HttpClient(context: SecurityContext(withTrustedRoots: false));
          // You can test the intermediate / root cert here. We just ignore it.
          client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
          return client;
        },
      );
    }
    // if(kDebugMode)
    //   {
    //     _baseUrl = 'https://bibilease.appupgo.co.il/?rest_route=/';
    //   }
    // else{
      //_baseUrl = 'https://bibilease.co.il/?rest_route=/';
    //_baseUrl = 'https://bibilease.quicksolutions.co.il/?rest_route=/';
    _baseUrl = 'https://app.bibilease.co.il/?rest_route=/';
  // }
  } // Private constructor for singleton

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() {
    return _instance;
  }

  Future getCarsAround(String start,String end,double lat,double long,int km,stime,etime,Function(dynamic carJson) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/get_vehicles_around_address1/$start/$end/$lat/$long/$km/$stime/$etime');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_vehicles_around_address1/$start/$end/$lat/$long/$km/$stime/$etime');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
      onSuccess(result);
    }
  }

  Future getUserOrders(int userId, Function(dynamic orderJson) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/get_history_orders_or_future_orders_by_customer/$userId');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_history_orders_or_future_orders_by_customer/$userId');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
  }


  Future getURLToPDF(int orderId, Function(dynamic orderJson) onSuccess) async {
    debugPrint('${_baseUrl}orders/get_customer_orders/$orderId');
    Response response = await _dio.get('${_baseUrl}orders/get_customer_orders/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getVerificationCode(String phone,int type, Function(dynamic carJson) onSuccess) async {
    debugPrint('sendType $type');
    debugPrint('${_baseUrl}wp/v2/check_user_connected/$type/$phone');
    // Response response = await _dio.get('${_baseUrl}wp/v2/check_user_connected/1/$phone');
    Response response = await _dio.get('${_baseUrl}wp/v2/check_user_connected/$type/$phone');

    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future sendCodeToRegistration(String phone,int type, Function(dynamic carJson) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/send_code_to_registration/$type/$phone');
    Response response = await _dio.get('${_baseUrl}wp/v2/send_code_to_registration/$type/$phone');

    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
      onSuccess(result);
    }
  }

  Future codeVerification(String phone,String code, Function(dynamic carJson) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/verificaion_customer/$code/$phone');
    Response response = await _dio.get('${_baseUrl}wp/v2/verificaion_customer/$code/$phone');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future registerCustomerDetails(Function(dynamic res) onSuccess) async {
    try {
      final bytes = User().signature;

      if (bytes == null || bytes.isEmpty) {
        debugPrint('signature is null or empty');
        return;
      }

      debugPrint('signature length: ${bytes.length}');
      debugPrint('first bytes: ${bytes.take(20).toList()}');

      final signature = MultipartFile.fromBytes(
        bytes,
        filename: 'signature.png',
        contentType: MediaType('image', 'png'),
      );
      FormData formData = FormData.fromMap({
        "file": signature,
        //MultipartFile.fromBytes(User().signature, filename: 'signature.jpg'), // Adjust filename and content type
        "text": User().toString(),
      });
      debugPrint('${_baseUrl}wp/v2/registration_customer_detailes');
      // debugPrint('data: ${User().toString()}');
      // debugPrint('data: ${signature.contentType}');


      Response response;
      try {
        response =
        await _dio.post('${_baseUrl}wp/v2/registration_customer_detailes',
            data: formData);

        debugPrint('Status: ${response.statusCode}');
        //debugPrint('Response: ${response.data}');
        debugPrint('getdata: ${response.data}');
        if (response.statusCode == 200) {
          onSuccess(response.data);
        }
      } on DioException catch (e) {
        debugPrint('Dio error type: ${e.type}');
        debugPrint('Status code: ${e.response?.statusCode}');
        debugPrint('Response data: ${e.response?.data}');
        debugPrint('Response headers: ${e.response?.headers}');
        debugPrint('Request data: ${e.requestOptions.data}');
        debugPrint('Request headers: ${e.requestOptions.headers}');
        debugPrint('Request uri: ${e.requestOptions.uri}');
      }
    }
    catch (e, s) {
      debugPrint('General error: $e');
      debugPrint('$s');
    }


  }

  getPaymentUrl(int id,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}tranzila/v1/get_tranzila_iframe/$id');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/get_tranzila_iframe/$id');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
      onSuccess(result);
    }
  }

  getStatusPayment(String phone,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}tranzila/v1/tranzila_status/$phone');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/tranzila_status/$phone');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
      onSuccess(result);
    }
  }

  Future getUserById(int id,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}customers/get_customer/$id');
    Response response = await _dio.get('${_baseUrl}customers/get_customer/$id');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

/*  Future fileUpload(Function() onSuccess) async {

    List<MultipartFile> imageFiles = [];

    if(!kIsWeb){
      for (var item in User().regImages) {
        if (item != null) {
          imageFiles.add(
            await MultipartFile.fromFile(
              item.path,
              filename: item.path.split('/').last,
            ),
          );
        }
      }
    }
    else{
   //   "license_front": img1!=null?MultipartFile.fromBytes(await img1.readAsBytes(), filename: "front.png"):null,
  int count=0;
    for (var item in User().regImages) {
        if (item != null) {
          count++;
          final bytes = await item.readAsBytes();
          imageFiles.add(
            MultipartFile.fromBytes(
              bytes,
              filename: item.name.isNotEmpty?item.name:'photo_$count.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        }
      }
    }
    FormData formData = FormData.fromMap({
      "license_front": imageFiles[0],
      "license_back": imageFiles[1],
      //"face": User().regImages[2]!=null?imageFiles[2]:-1,
      if (User().regImages.length > 2) "face": imageFiles[2],
      "user_phone":User().phoneNumber,
    });
    //phpPrintFormData(formData);


    var response = await _dio.post('${_baseUrl}wp/v2/upload_license', data: formData,);
    debugPrint("response.statusCode ${response.statusCode}");
    if(response.statusCode == 200) {
      debugPrint("response.data ${response.data.toString()}");
      onSuccess();
    }
    else {
      debugPrint(response.statusCode.toString());
    }
  }*/


  Future fileUpload(BuildContext context, Function() onSuccess) async {
    final dio = Dio();
    List<MultipartFile> imageFiles = [];
    int count = 0;

    for (var item in User().regImages) {
      if (item != null) {
        count++;

        try {
          String fileName = '';
          List<int> bytes = [];

          if (kIsWeb) {
            //  במצב WEB – משתמשים ב-bytes
            bytes = await item.readAsBytes();
            fileName = item.name.isNotEmpty
                ? item.name
                : 'photo_$count${DateTime.now().millisecondsSinceEpoch}.jpg';
          } else {
            //  במובייל – משתמשים ב-path אמיתי
            if (item.path.isNotEmpty) {
              final file = File(item.path);
              if (await file.exists()) {
                bytes = await file.readAsBytes();
                fileName = item.path.split('/').last.isNotEmpty
                    ? item.path.split('/').last
                    : 'photo_$count${DateTime.now().millisecondsSinceEpoch}.jpg';
              } else {
                debugPrint('הקובץ ${item.path} לא קיים');
                await Sentry.captureMessage(
                  'Mobile file not found at path: ${item.path}',
                  withScope: (scope) => scope.setTag('context', 'upload_mobile'),
                );
                continue;
              }
            } else {
              debugPrint('ath ריק במובייל');
              await Sentry.captureMessage(
                'Mobile image with empty path (index $count)',
                withScope: (scope) => scope.setTag('context', 'upload_mobile'),
              );
              continue;
            }
          }

          // בדיקה סופית לפני ההוספה
          if (bytes.isEmpty) {
            await Sentry.captureMessage(
              'Skipped file – empty bytes (index $count)',
              withScope: (scope) => scope.setTag('context', 'upload_license'),
            );
            continue;
          }

          imageFiles.add(
            MultipartFile.fromBytes(
              bytes,
              filename: fileName,
              contentType: MediaType('image', 'jpeg'),
            ),
          );

          debugPrint('✅ מוסיף קובץ $fileName (${bytes.length} bytes)');
        } catch (e, st) {
          debugPrint('❌ שגיאה בעיבוד קובץ $count: $e');
          await Sentry.captureException(e, stackTrace: st);
          displayMessage(context,message: 'ישנה בעיה, נסה שנית');

        }
      }
    }



    imageFiles.removeWhere((f) {
      final isNameEmpty = f.filename == null || f.filename!.isEmpty;
      final isEmptyBytes = f.length == 0; // או אם אתה רוצה לבדוק גודל אחר

      if (isNameEmpty || isEmptyBytes) {
        // שליחת דיווח ל-Sentry
        Sentry.captureMessage(
          '⚠️ Removed invalid file',
          withScope: (scope) {
            scope.setExtra('filename', f.filename);
            scope.setExtra('fileLength', f.length);
          },
        );

        debugPrint('הסרת קובץ לא תקין: ${f.filename ?? "ללא שם"}');
        return true; // true => להסיר מהרשימה
      }

      return false; // false => להשאיר
    });

    if (imageFiles.isEmpty) {
      debugPrint('⚠️ אין קבצים תקינים להעלאה');
displayMessage(context,message: 'ישנה בעיה, נסה שנית');
      await Sentry.captureMessage(
        'No valid image files to upload',
        level: SentryLevel.warning,
      );
      return;
    }

    final formData = FormData.fromMap({
      if (imageFiles.length > 0) "license_front": imageFiles[0],
      if (imageFiles.length > 1) "license_back": imageFiles[1],
      if (imageFiles.length > 2) "face": imageFiles[2],
      "user_phone": User().phoneNumber,
    });

    debugPrint(' נשלחות ${imageFiles.length} תמונות');

    try {
      final response = await dio.post(
        '${_baseUrl}wp/v2/upload_license',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      debugPrint("response.statusCode: ${response.statusCode}");
      debugPrint("response.data: ${response.data}");

      if (response.statusCode == 200 && response.data.toString().contains('OK')  ) {
        debugPrint(" העלאה הצליחה!");
        onSuccess();
      } else {
        debugPrint("העלאה נכשלה או תשובה חריגה");
        await Sentry.captureMessage(
          'Upload failed with data: ${response.data}',
          level: SentryLevel.error,
        );
        displayMessage(context,message: 'ישנה בעיה, נסה שנית');

      }
    } catch (e, st) {
      debugPrint('❌ שגיאת תקשורת: $e');
      await Sentry.captureException(e, stackTrace: st);
      displayMessage(context,message: 'ישנה בעיה, נסה שנית');

    }
  }




  Future newOrder( Map<String, dynamic> jsonMap,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}orders/new_order');
   debugPrint('data : ${json.encode(jsonMap)}');

    Response response = await _dio.post('${_baseUrl}orders/new_order',
      data: json.encode(jsonMap));
    // debugPrint('response $response');
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }

  Future getAdditions(int carId,startDate, endDate ,Function(dynamic orderJson) onSuccess) async {

    String d1=intl.DateFormat('yyyy-MM-dd').format(startDate);
    String d2=intl.DateFormat('yyyy-MM-dd').format(endDate);
    String h1=intl.DateFormat('HH:mm').format(startDate);
    String h2=intl.DateFormat('HH:mm').format(endDate);
    debugPrint('${_baseUrl}wp/v2/get_extras_for_rent/$carId/$d1*$d2/$h1*$h2');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_extras_for_rent/$carId/$d1*$d2/$h1*$h2');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future returnCar(int orderId ,Function(dynamic orderJson) onSuccess) async {
    //DateTime nextDay= endDate.add(Duration(days: 1));
    debugPrint('${_baseUrl}tranzila/v1/update_return_car/$orderId');
    // Response response = await _dio.get('${_baseUrl}wp/v2/get_extras_for_rent/7994');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/update_return_car/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }


  Future getCarsAvailableOrNot(Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/get_cars_active_or_available');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_cars_active_or_available');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getOpeningCode(int orderId,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/return_code_open_doors/$orderId');
    Response response = await _dio.get('${_baseUrl}wp/v2/return_code_open_doors/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getFuelLevel(int carNum,Function(dynamic res) onSuccess) async {
   // https://bibilease.quicksolutions.co.il/wp-json/wp/v2/get_car_fuel_level_by_KM_and_by_fuel_percentage/73592802
    debugPrint('${_baseUrl}wp/v2/get_car_fuel_level_by_KM_and_by_fuel_percentage/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_car_fuel_level_by_KM_and_by_fuel_percentage/$carNum');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getTimeRemain(int orderId,Function(dynamic res) onSuccess) async {

    debugPrint('${_baseUrl}wp/v2/get_remaining_rental_time/$orderId');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_remaining_rental_time/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future sendFeedback( Map<String, dynamic> jsonMap,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/get_feedback');
    debugPrint('data : ${json.encode(jsonMap)}');

    Response response = await _dio.post('${_baseUrl}wp/v2/get_feedback',
        data: json.encode(jsonMap));
    // debugPrint('response $response');
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }


    Future signatureUpload(signature,orderId,Function() onSuccess) async {

      FormData formData = FormData.fromMap({
        "file" : MultipartFile.fromBytes(signature, filename: "signature.png"),
      });

      debugPrint('${_baseUrl}rental/v1/cancel_rental/$orderId');
      debugPrint('orderId $orderId');
      var response = await _dio.post('${_baseUrl}rental/v1/cancel_rental/$orderId', data: formData,);
      debugPrint("response.statusCode ${response.statusCode}");
      if(response.statusCode == 200) {
        debugPrint("response.data ${response.data.toString()}");
        onSuccess();
      }

    }

  Future openDoors(int carNum,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/vehicle_UNlock/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/vehicle_UNlock/$carNum');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the s0erver
  }

  Future lockDoors(int carNum,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/vehicle_lock/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/vehicle_lock/$carNum');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

    Future updatePersonalDetails( Map<String, dynamic> jsonMap,Function(dynamic res) onSuccess) async {
      debugPrint('${_baseUrl}wp/v2/update_personal_information');
      debugPrint('data : ${json.encode(jsonMap)}');

      Response response = await _dio.post('${_baseUrl}wp/v2/update_personal_information',
          data: json.encode(jsonMap));
      // debugPrint('response $response');
      debugPrint('data: ${response.data}');
      if(response.statusCode==200) {
        onSuccess(response.data);
      }

    }

  Future updatePersonalContact( Map<String, dynamic> jsonMap,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/update_personal_contact');
    debugPrint('data : ${json.encode(jsonMap)}');

    Response response = await _dio.post('${_baseUrl}wp/v2/update_personal_contact',
        data: json.encode(jsonMap));
    // debugPrint('response $response');
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }
  Future updatePersonalDriverLicense( Map<String, dynamic> jsonMap,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/update_driving_license_personal');
    debugPrint('data : ${json.encode(jsonMap)}');

    Response response = await _dio.post('${_baseUrl}wp/v2/update_driving_license_personal',
        data: json.encode(jsonMap));
    // debugPrint('response $response');
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }
  }

  Future deleteAccount(int customerID,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}customer/update_status_customr/$customerID');
    Response response = await _dio.get('${_baseUrl}customer/update_status_customr/$customerID');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
  }

  Future getAdditionalDriver(String id,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/get_additional_driver/${User().tz}/$id');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_additional_driver/${User().tz}/$id');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
    
  }

  Future addDriverToActiveRent( int orderId, Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/update_additional_driver_on_rent');

    var img1=User().additionalDriver.images[0];
    var img2=User().additionalDriver.images[1];

    FormData formData = FormData.fromMap({
      "order_id": orderId,
      "id": User().additionalDriver.id,
      "license_number": User().additionalDriver.licenseId,
      "license_level": User().additionalDriver.licenseDegree,
      "license_date": User().additionalDriver.licenseIssDate,
      "license_exp": User().additionalDriver.licenseExpDate,
      "new_driver": User().additionalDriver.isNewDriver,
      "license_front": img1!=null?MultipartFile.fromBytes(await img1.readAsBytes(), filename: "front.png"):null,
      "license_back": img2!=null?MultipartFile.fromBytes(await img2.readAsBytes(), filename: "back.png"):null,
    });

       Response response = await _dio.post('${_baseUrl}wp/v2/update_additional_driver_on_rent',
        data: formData);
    // debugPrint('response $response');
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }

  Future addDriverToUser(Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/update_additional_driver');
    List<MultipartFile> imageFiles = [];

    debugPrint(User().additionalDriver.images.length.toString()); //2

  /*  imageFiles.add(
      await MultipartFile.fromFile(
        User().additionalDriver.images[0]!.path,
        filename: 'front.png',
      ),
    );
    debugPrint('======');

    imageFiles.add(
      await MultipartFile.fromFile(
        User().additionalDriver.images[1]!.path,
        filename: 'back.png',
      ),
    );
    debugPrint('======');

    debugPrint(imageFiles.length);*/
    //String d1=intl.DateFormat('yyyy-MM-dd').format(User().additionalDriver.licenseIssDate);
    //String d2=intl.DateFormat('yyyy-MM-dd').format(User().additionalDriver.licenseExpDate);

    var img1=User().additionalDriver.images[0];
    var img2=User().additionalDriver.images[1];

    FormData formData = FormData.fromMap({
      "customer_id": User().tz,
      "id": User().additionalDriver.id,
      "license_number": User().additionalDriver.licenseId,
      "license_level": User().additionalDriver.licenseDegree,
      "license_date": User().additionalDriver.licenseIssDate,
      "license_exp": User().additionalDriver.licenseExpDate,
      "new_driver": User().additionalDriver.isNewDriver,
      "license_front": img1!=null?MultipartFile.fromBytes(await img1.readAsBytes(), filename: "front.png"):null,
      "license_back": img2!=null?MultipartFile.fromBytes(await img2.readAsBytes(), filename: "back.png"):null,
    });

    debugPrint(formData.fields.toString());
    Response response = await _dio.post('${_baseUrl}wp/v2/update_additional_driver',
        data: formData);
    // debugPrint('response $response');
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }
  }

  Future getPriceList(Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}payment/v2/price_list_api');
    Response response = await _dio.get('${_baseUrl}payment/v2/price_list_api');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
  }

  Future getPromotions(Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}payment/v2/get_promotions_api');
    Response response = await _dio.get('${_baseUrl}payment/v2/get_promotions_api');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
  }

  Future getParkPosition(int carNum,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/car_address_location/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/car_address_location/$carNum');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint('result: $result');
      onSuccess(result);
    }
  }
    
  Future getStatusPaymentAfterUpdate(String phone,Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}tranzila/v1/tranzila_status_after_update/$phone');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/tranzila_status_after_update/$phone');
    if(response.statusCode == 200) {
      var result = response.data;
      debugPrint(result.toString());
    onSuccess(result);

    }
  }

  Future carDocumentation(int carNum ,List<XFile?> images,Function(dynamic res) onSuccess) async {
    List<MultipartFile> imageFiles = [];

    if(!kIsWeb) {
      for (var item in images) {
        if (item != null) {
          imageFiles.add(
            await MultipartFile.fromFile(
              item.path,
              filename: item.path
                  .split('/')
                  .last,
            ),
          );
        }
      }
    }
    else {
      // debugPrint('webbbbbb');
      // for (var item in images) {
      //   if (item != null) {
      //     final bytes = await item.readAsBytes();
      //     imageFiles.add(
      //       await MultipartFile.fromBytes(
      //         bytes,
      //         filename: item.name,
      //       ),
      //     );
      //   }
      // }


      for (var item in images) {
        if (item != null) {
          debugPrint('item.name ${item.name}');
          try {
            final bytes = await item.readAsBytes();

            // Check if name is available; fallback if needed
            String fileName = item.name.isNotEmpty
                ? item.name
                : 'image_${DateTime
                .now()
                .millisecondsSinceEpoch}.jpg';

            imageFiles.add(
              MultipartFile.fromBytes(
                bytes,
                filename: fileName,
              ),
            );
          } catch (e) {
            debugPrint('Error reading image bytes on web: $e');
          }
        }
      }
    }
    /*FormData formData = FormData.fromMap({
      "image_1": imageFiles[0],
      "image_2": imageFiles[1],
      "image_3": imageFiles[2],
      "image_4": imageFiles[3],

    });*/

    final Map<String, dynamic> data = {};

    for (int i = 0; i < imageFiles.length; i++) {
      data['image_${i + 1}'] = imageFiles[i];
    }

    FormData formData = FormData.fromMap(data);

    debugPrint('${_baseUrl}wp/v2/Vehicle_documentation/$carNum');
    debugPrint('data : $formData');
    Response response = await _dio.post('${_baseUrl}wp/v2/Vehicle_documentation/$carNum',
        // data: json.encode(formData));
        data: formData);
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }

  Future reportAccident(XFile? image, text, email, phone, name, Function(dynamic res) onSuccess) async {
    debugPrint('${_baseUrl}wp/v2/report_fault');
    //var bytes = image?.readAsBytes();
    FormData formData = FormData.fromMap({
      "image_report_fault" : image!=null?MultipartFile.fromBytes(await image.readAsBytes(), filename: "image.png"):null,
      "message": text,
      "customer_email":email,
      "customer_phon": phone,
      "customer_name": name,
      "customer_id": User().userId,
    });


    var response = await _dio.post('${_baseUrl}wp/v2/report_fault', data: formData,);
    debugPrint("response.statusCode ${response.statusCode}");
    if(response.statusCode == 200) {
      debugPrint("response.data ${response.data.toString()}");
      onSuccess(response.data);
    }

  }

  Future faceRecognition(String phone ,Function(dynamic res) onSuccess) async {
    List<MultipartFile> imageFiles = [];
    debugPrint('in API - ${User().regImages[0]!.path}');
    bool hasImageFace=User().regImages[2]!=null;
    debugPrint('hasImageFace - $hasImageFace');
    if(!kIsWeb) {
      imageFiles.add(
        await MultipartFile.fromFile(
        User().regImages[0]!.path,
        filename: User().regImages[0]!.path.split('/').last,
        ),
      );

      debugPrint(hasImageFace?'true':'false');
      if(hasImageFace) {
        imageFiles.add(
        await MultipartFile.fromFile(
          User().regImages[2]!.path,
          filename: User().regImages[2]!.path.split('/').last,
        ),
      );
      }
    }
    else{
      final bytes = await User().regImages[0]!.readAsBytes();
      imageFiles.add(
         MultipartFile.fromBytes(
          bytes,
          //filename: User().regImages[0]!.name,
           filename:  User().regImages[0]!.name.isNotEmpty? User().regImages[0]!.name:'photo_1.jpg',
           contentType: MediaType('image', 'jpeg'),

        ),
      );

      debugPrint(hasImageFace?'true':'false');
      if(hasImageFace) {
       String name= User().regImages[2]!.path.split('/').last;
        final bytes1 = await User().regImages[2]!.readAsBytes();
        imageFiles.add(
           MultipartFile.fromBytes(
            bytes1,
            // filename: User().regImages[2]!.path.split('/').last,
             filename:name.isNotEmpty?name:'photo_2.jpg',
             contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
    }

    debugPrint('uploadList.toString() ${imageFiles.toString()}');
    FormData formData = FormData.fromMap({
      "license_front": imageFiles[0],
     // "face": User().regImages[2]!=null?imageFiles[1]:null,
    if ( hasImageFace)   "face":imageFiles[1]
    });


    int hasFace=!hasImageFace?1:0;

    debugPrint('${_baseUrl}wp/v2/is_same_person/$phone/$hasFace');
    //debugPrint('data : ${json.encode(formData)}');
    Response response = await _dio.post('${_baseUrl}wp/v2/is_same_person/$phone/$hasFace',
        data: formData);
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }



  void phpPrintFormData(FormData formData) {
    debugPrint('--------------------');
    debugPrint('🧾 FormData Debug Print');
    debugPrint('--------------------');

    // print normal fields
    for (var field in formData.fields) {
      debugPrint('[${field.key}] => ${field.value}');
    }

    // print files like PHP’s $_FILES array
    for (var fileEntry in formData.files) {
      final file = fileEntry.value;
      debugPrint('[${fileEntry.key}] => Array (');
      debugPrint('  [filename] => ${file.filename}');
      if (file.length != null) debugPrint('  [length] => ${file.length}');
      debugPrint(')');
    }

    debugPrint('--------------------');
  }

}
