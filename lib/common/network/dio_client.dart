import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: const String.fromEnvironment(
        'WIKIDATA_BASE_URL',
        defaultValue: 'https://www.wikidata.org',
      ),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      queryParameters: {'format': 'json', 'formatversion': 2, 'origin': '*'},
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(requestHeader: false, responseHeader: false),
    );
  }
  return dio;
}
