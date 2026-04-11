import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/auth_interceptor.dart';

class DioFactory {
  Dio createDio() {
    final dio = Dio()
      ..interceptors.add(AuthInterceptor())
      ..interceptors.add(
        LogInterceptor(
          responseBody: true,
          logPrint: (o) => debugPrint(o.toString()),
        ),
      );

    return dio;
  }
}
