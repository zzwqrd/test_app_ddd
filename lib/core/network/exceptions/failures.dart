import 'package:dio/dio.dart';

class Failure<T> {
  String? message;
  int? statusCode;
  bool success;
  int? errType;
  Response? response;
  T? data;
  Failure({
    this.success = false,
    this.errType = 0,
    this.message = "",
    this.statusCode = 0,
    this.response,
    this.data,
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    super.success = false,
    super.errType = 0,
    super.message = "",
    super.statusCode = 0,
    super.response,
    super.data,
  });
}

class NotFoundFailure<T> extends Failure {
  final String? message;
  final int? statusCode;
  final bool success;
  final int? errType;
  final Response? response;
  final T? data;

  // NotFoundFailure({required this.message, required this.statusCode});
  NotFoundFailure({
    this.success = false,
    this.errType = 0,
    this.message = "",
    this.statusCode = 0,
    this.response,
    this.data,
  });
}

class ClientFailure extends Failure {
  ClientFailure({
    super.message,
    super.statusCode,
  });
}
