import 'package:dio/dio.dart';

import '../utils/helpers/app_string.dart';
import 'api_config.dart';
import 'dio_exception.dart';
import 'dio_interceptor.dart';

class DioClient {
  static final DioClient instance = DioClient._internal();
  final Dio _dio = Dio();
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);
  static const header = {
    'content-Type': 'application/json',
  };

  factory DioClient() {
    return instance;
  }

  DioClient._internal() {
    _dio
      ..options.baseUrl = ApiConfig.baseUrl
      ..options.headers = header
      ..options.connectTimeout = connectionTimeout
      ..options.receiveTimeout = receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(DioInterceptor());
  }

  Future<Response> getRequest(
      {required String url, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
          url.startsWith("http") ? url : "${ApiConfig.baseUrl}/$url",
          queryParameters: queryParams);
      return response;
    } on DioException catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    } catch (error) {
      throw Exception(AppString.unknownError);
    }
  }

  Future<Response> postRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    } catch (error) {
      throw Exception(AppString.unknownError);
    }
  }

  Future<Response> putRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    } catch (error) {
      throw Exception(AppString.unknownError);
    }
  }

  Future<Response> deleteRequest(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    } catch (error) {
      throw Exception(AppString.unknownError);
    }
  }

  Dio get dio => _dio;
}

// class DioClient {
//   static final i = DioClient._();
//   final _dio = Dio();
//   static const Duration receiveTimeout = Duration(milliseconds: 15000);
//   static const Duration connectionTimeout = Duration(milliseconds: 15000);
//   static const header = {
//     // 'Authorization': 'Bearer $token',
//     'content-Type': 'application/json',
//   };
//   @override
//   DioClient._() {
//     _dio
//       ..options.baseUrl = ApiConfig.baseUrl
//       ..options.headers = header
//       ..options.connectTimeout = connectionTimeout
//       ..options.receiveTimeout = receiveTimeout
//       ..options.responseType = ResponseType.json
//       ..interceptors.add(DioInterceptor());
//   }
// }
