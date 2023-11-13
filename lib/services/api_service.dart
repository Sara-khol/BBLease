import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio _dio = Dio();
  final _baseUrl = 'https://bibilease.co.il/?rest_route=/';

  ApiService._privateConstructor(); // Private constructor for singleton

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() {
    return _instance;
  }
  void getAllCars(  Function(dynamic carJson) onSuccess) async {
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
    Response response = await _dio.get('${_baseUrl}wp/v2/get_all_vehicles');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }
   getCarById(int carId, Function(dynamic carJson) onSuccess) async {
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
    Response response = await _dio.get('${_baseUrl}wp/v2/get_vehicle/${carId}');
    if(response.statusCode == 200) {
      var result = response.data;
      print(result);
      onSuccess(result);
    }
    // Prints the raw data returned by the server
  }
}
