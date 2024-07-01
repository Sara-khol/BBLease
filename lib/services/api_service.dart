import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

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
  /*Future getAllCars(  Function(dynamic carJson) onSuccess) async {
    Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }*/

  /*Future getCarById(int carId, Function(dynamic carJson) onSuccess) async {

    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_vehicle/$carId');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }*/

  /*Future getCarsInBranch(String city, Function(dynamic carJson) onSuccess) async {

    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_list_vehicles_by_city/$city');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }*/

  Future getCarsAround(String start,String end,double lat,double long,int km,stime,etime,Function(dynamic carJson) onSuccess) async {
    print('${_baseUrl}wp/v2/get_vehicles_around_address1/$start/$end/$lat/$long/$km/$stime/$etime');

    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_vehicles_around_address1/$start/$end/$lat/$long/$km/$stime/$etime');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getUserOrders(int userId, Function(dynamic orderJson) onSuccess) async {
    print('${_baseUrl}wp/v2/get_history_orders_or_future_orders_by_customer/$userId');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_history_orders_or_future_orders_by_customer/$userId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  /*Future getUserAllOrders(int userId, Function(dynamic orderJson) onSuccess) async {
    print('${_baseUrl}wp/v2/get_history_orders_or_future_orders_by_customer/$userId');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_history_orders_or_future_orders_by_customer/$userId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }*/

  Future getURLToPDF(int orderId, Function(dynamic orderJson) onSuccess) async {
    print('${_baseUrl}orders/get_customer_orders/$orderId');

    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}orders/get_customer_orders/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getVerificationCode(String phone,int type, Function(dynamic carJson) onSuccess) async {
    //int sendType=isSms?0:1;
    print('sendType $type');
    // print('${_baseUrl}wp/v2/check_user_connected/$sendType/$phone');
    print('${_baseUrl}wp/v2/check_user_connected/$type/$phone');
    // Response response = await _dio.get('${_baseUrl}wp/v2/check_user_connected/1/$phone');
    Response response = await _dio.get('${_baseUrl}wp/v2/check_user_connected/$type/$phone');
    ///*Response response = await*/ _dio.get('${_baseUrl}wp/v2/check_user_connected/2/$phone');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future codeVerification(String phone,String code, Function(dynamic carJson) onSuccess) async {
    print('${_baseUrl}wp/v2/verificaion_customer/$code/$phone');
    Response response = await _dio.get('${_baseUrl}wp/v2/verificaion_customer/$code/$phone');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future registerCustomerDetails(Function(dynamic res) onSuccess) async {
    var signature=MultipartFile.fromBytes(User().signature!, filename: 'signature.jpg');
    FormData formData = FormData.fromMap({
      "file": signature,//MultipartFile.fromBytes(User().signature, filename: 'signature.jpg'), // Adjust filename and content type
      "text": User().toString(),
    });
    print('${_baseUrl}wp/v2/registration_customer_detailes');
    print('data: ${User().toString()}');
    print('data: ${signature.contentType}');
    Response response = await _dio.post('${_baseUrl}wp/v2/registration_customer_detailes',
        data: formData);
   // debugPrint('response $response');
    debugPrint('getdata: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }

  getPaymentUrl(int id,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}tranzila/v1/get_tranzila_iframe/$id');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/get_tranzila_iframe/$id');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
  }

  getStatusPayment(String phone,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}tranzila/v1/tranzila_status/$phone');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/tranzila_status/$phone');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
  }

  Future getUserById(int id,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}customers/get_customer/$id');
    Response response = await _dio.get('${_baseUrl}customers/get_customer/$id');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future fileUpload(Function() onSuccess) async {

    List<MultipartFile> imageFiles = [];

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
    //uploadList.add('0533117933');
    print('uploadList.toString() ${imageFiles.toString()}');
    FormData formData = FormData.fromMap({
      "license_front": imageFiles[0],
      "license_back": imageFiles[1],
      "face": imageFiles[2],
      // "user_phone":'0533117933',
      "user_phone":User().phoneNumber,
    });

    var response = await _dio.post('${_baseUrl}wp/v2/upload_license', data: formData,);
    print("response.statusCode ${response.statusCode}");
    if(response.statusCode == 200) {
      print("response.data ${response.data.toString()}");
      onSuccess();
    }
    else {
      print(response.statusCode);
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
     //DateTime nextDay= endDate.add(Duration(days: 1));
    String d1=intl.DateFormat('yyyy-MM-dd').format(startDate);
    String d2=intl.DateFormat('yyyy-MM-dd').format(endDate);

    print('${_baseUrl}wp/v2/get_extras_for_rent/$carId/$d1*$d2');
    // Response response = await _dio.get('${_baseUrl}wp/v2/get_extras_for_rent/7994');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_extras_for_rent/$carId/$d1*$d2');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future returnCar(int orderId ,Function(dynamic orderJson) onSuccess) async {
    //DateTime nextDay= endDate.add(Duration(days: 1));
    print('${_baseUrl}tranzila/v1/update_return_car/$orderId');
    // Response response = await _dio.get('${_baseUrl}wp/v2/get_extras_for_rent/7994');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/update_return_car/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }


  Future getCarsAvailableOrNot(Function(dynamic res) onSuccess) async {
    print('${_baseUrl}wp/v2/get_cars_active_or_available');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_cars_active_or_available');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getOpeningCode(int orderId,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}wp/v2/return_code_open_doors/$orderId');
    Response response = await _dio.get('${_baseUrl}wp/v2/return_code_open_doors/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getFuelLevel(int carNum,Function(dynamic res) onSuccess) async {
    https://bibilease.quicksolutions.co.il/wp-json/wp/v2/get_car_fuel_level_by_KM_and_by_fuel_percentage/73592802
    print('${_baseUrl}wp/v2/get_car_fuel_level_by_KM_and_by_fuel_percentage/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_car_fuel_level_by_KM_and_by_fuel_percentage/$carNum');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getTimeRemain(int orderId,Function(dynamic res) onSuccess) async {

    print('${_baseUrl}wp/v2/get_remaining_rental_time/$orderId');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_remaining_rental_time/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
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


    Future signatureUpload(signature,Function() onSuccess) async {

      FormData formData = FormData.fromMap({
        "file" : MultipartFile.fromBytes(signature, filename: "signature.png"),
        "post_id": User().userId
      });

      print('${_baseUrl}wp/v2/save_signature');
      var response = await _dio.post('${_baseUrl}wp/v2/save_signature', data: formData,);
      print("response.statusCode ${response.statusCode}");
      if(response.statusCode == 200) {
        print("response.data ${response.data.toString()}");
        onSuccess();
      }
      else {
        print(response.statusCode);
      }
    }

  Future openDoors(int carNum,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}wp/v2/vehicle_UNlock/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/vehicle_UNlock/$carNum');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future lockDoors(int carNum,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}wp/v2/vehicle_lock/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/vehicle_lock/$carNum');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
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
    print('${_baseUrl}customer/update_status_customr/$customerID');
    Response response = await _dio.get('${_baseUrl}customer/update_status_customr/$customerID');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
  }

  Future getAdditionalDriver(String id,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}wp/v2/get_additional_driver_details/$id');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_additional_driver_details/$id');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    
  }

  Future getPriceList(Function(dynamic res) onSuccess) async {
    print('${_baseUrl}payment/v2/price_list_api');
    Response response = await _dio.get('${_baseUrl}payment/v2/price_list_api');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
  }

  Future getPromotions(Function(dynamic res) onSuccess) async {
    print('${_baseUrl}payment/v2/get_promotions_api');
    Response response = await _dio.get('${_baseUrl}payment/v2/get_promotions_api');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
  }

  Future getParkPosition(int carNum,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}wp/v2/car_address_location/$carNum');
    Response response = await _dio.get('${_baseUrl}wp/v2/car_address_location/$carNum');
    print(response.statusCode);
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
  }
    
  Future getStatusPaymentAfterUpdate(String phone,Function(dynamic res) onSuccess) async {
    print('${_baseUrl}tranzila/v1/tranzila_status_after_update/$phone');
    Response response = await _dio.get('${_baseUrl}tranzila/v1/tranzila_status_after_update/$phone');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
  }

  Future carDocumentation(int carNum ,List<XFile?> images,Function(dynamic res) onSuccess) async {
    List<MultipartFile> imageFiles = [];
    for (var item in images) {
      if (item != null) {
        imageFiles.add(
          await MultipartFile.fromFile(
            item.path,
            filename: item.path.split('/').last,
          ),
        );
      }
    }

    FormData formData = FormData.fromMap({
      "image_1": imageFiles[0],
      "image_2": imageFiles[1],
      "image_3": imageFiles[2],
      "image_4": imageFiles[3],

    });

    debugPrint('${_baseUrl}wp/v2/Vehicle_documentation/$carNum');
    debugPrint('data : ${json.encode(formData)}');
    Response response = await _dio.post('${_baseUrl}wp/v2/Vehicle_documentation/$carNum',
        data: json.encode(formData));
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }

  Future faceRecognition(String phone ,Function(dynamic res) onSuccess) async {
    List<MultipartFile> imageFiles = [];
    imageFiles.add(
      await MultipartFile.fromFile(
      User().regImages[0]!.path,
      filename: User().regImages[0]!.path.split('/').last,
      ),
    );
    imageFiles.add(
      await MultipartFile.fromFile(
        User().regImages[2]!.path,
        filename: User().regImages[2]!.path.split('/').last,
      ),
    );

    print('uploadList.toString() ${imageFiles.toString()}');
    FormData formData = FormData.fromMap({
      "license_front": imageFiles[0],
      "face": imageFiles[2],
    });

    debugPrint('${_baseUrl}wp/v2/is_same_person/$phone');
    debugPrint('data : ${json.encode(formData)}');
    Response response = await _dio.post('${_baseUrl}wp/v2/is_same_person/$phone',
        data: json.encode(formData));
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }

  }

}
