import 'dart:convert';

import 'package:dio/dio.dart';


import 'api_service.dart';

class ApiServicesImp implements ApiServices {
  final Dio _dio;
  late Map<String, dynamic> _headers;

  ApiServicesImp(this._dio) {
    _dio.options
      ..baseUrl = 'https://plants.yorkbritishacademy.uk'
      ..responseType = ResponseType.plain
      ..sendTimeout =Duration(seconds: 30)
      ..receiveTimeout = Duration(seconds: 30)
      ..connectTimeout = Duration(seconds: 10)
      ..followRedirects = true;
  }

  Future<void> setHeaders(bool hasToken) async {
    _headers = await {
      "Accept": "application/json",
      "accept-timezone":DateTime.now().timeZoneName,
     };

  }


  @override
  Future get(String path,
      {Map<String, String>? queryParams, bool? hasToken}) async {
    try {
      await setHeaders(hasToken ?? true);
      var response = await _dio.get(
        path,
        queryParameters: queryParams,
        options: Options(headers: _headers),
      );
     var map=jsonDecode(response.data);
      map['status']=true;
      map['message']='Done Connect';
      return map;
    } catch ( error) {
      print(error);
      return{'status':false,"message":error.toString().substring(0,50)};
    }

  }

}
