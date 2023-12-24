import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

import '../models/class_user.dart';

class ApiService {
  final Dio _dio = Dio();
  final _baseUrl = 'https://bibilease.co.il/?rest_route=/';

  ApiService._privateConstructor(){
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
  } // Private constructor for singleton

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() {
    return _instance;
  }
  Future getAllCars(  Function(dynamic carJson) onSuccess) async {
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

    Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getCarById(int carId, Function(dynamic carJson) onSuccess) async {
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
    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_vehicle/$carId');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getCarsInBranch(String city, Function(dynamic carJson) onSuccess) async {
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
    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_list_vehicles_by_city/$city');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getCarsAround(String start,String end,double lat,double long,int km, Function(dynamic carJson) onSuccess) async {
    print('${_baseUrl}wp/v2/get_vehicles_around_address/$start/$end/$lat/$long/$km/1');

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
    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}wp/v2/get_vehicles_around_address/$start/$end/$lat/$long/$km/1');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }


  Future getUserOrders(int userId, Function(dynamic orderJson) onSuccess) async {
    print('${_baseUrl}orders/get_customer_orders/$userId');
    Response response = await _dio.get('${_baseUrl}orders/get_customer_orders/$userId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }

  Future getURLToPDF(int orderId, Function(dynamic orderJson) onSuccess) async {
    print('${_baseUrl}orders/get_customer_orders/$orderId');
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
    // Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    Response response = await _dio.get('${_baseUrl}orders/get_customer_orders/$orderId');
    if(response.statusCode == 200) {
      var result = response.data;
      print('result: $result');
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }


  Future getVerificationCode(String phone,bool isSms, Function(dynamic carJson) onSuccess) async {
    /*_dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
        HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );*/
    int sendType=isSms?0:1;
    debugPrint('sendType $sendType');
    // print('${_baseUrl}wp/v2/check_user_connected/$sendType/$phone');
    print('${_baseUrl}wp/v2/check_user_connected/1/$phone');
    Response response = await _dio.get('${_baseUrl}wp/v2/check_user_connected/1/$phone');
    // Response response = await _dio.get('${_baseUrl}wp/v2/check_user_connected/$sendType/$phone');
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

  Future registerCustomerDetails(Function(dynamic res) onSuccess) async
  {
    print('${_baseUrl}wp/v2/registration_customer_detailes');
    print('data: ${User().toJson()}');
    Response response = await _dio.post('${_baseUrl}wp/v2/registration_customer_detailes',
        data: User().toJson());
   // debugPrint('response $response');
    debugPrint('data: ${response.data}');
    if(response.statusCode==200) {
      onSuccess(response.data);
    }
    else
      {

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



}
