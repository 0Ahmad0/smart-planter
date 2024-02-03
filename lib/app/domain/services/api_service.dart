
import 'package:flutter/material.dart';

abstract class ApiServices {
  Future<dynamic> get(String path,
      {Map<String, String>? queryParams, bool? hasToken});

}
