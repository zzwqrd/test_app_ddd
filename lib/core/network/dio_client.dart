import 'package:dio/dio.dart' show Dio, ResponseType;

import 'api_config.dart';
import 'dio_interceptor.dart';

class DioClient {
  static final i = DioClient._();
  final _dio = Dio();
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);
  static const header = {
    // 'Authorization': 'Bearer $token',
    'content-Type': 'application/json',
  };
  @override
  DioClient._() {
    _dio
      ..options.baseUrl = ApiConfig.baseUrl
      ..options.headers = header
      ..options.connectTimeout = connectionTimeout
      ..options.receiveTimeout = receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(DioInterceptor());
  }
}
