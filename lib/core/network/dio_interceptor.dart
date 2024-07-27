import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/helpers/loger.dart';

class DioInterceptor extends Interceptor {
  final LoggerDebug log =
      LoggerDebug(headColor: LogColors.red, constTitle: "Server Gate Logger");
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.red("\x1B[37m------ Current Error Response -----\x1B[0m");
    log.red("\x1B[31m🧚🧚🧚🧚🧚🧚🧚 ${err.response?.data}\x1B[0m");
    log.red("\x1B[37m------ Current Error StatusCode -----\x1B[0m");
    log.red(
        "\x1B[31m \x1B🧚🧚🧚🧚🧚🧚🧚     ${err.response?.statusCode}\x1B[0m");

    // push(NamedRoutes.i.sign_in);
    // showErrorDialogue("not find");
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log.green("------ Current Response ------");
    log.green("\x1B   ${jsonEncode(response.data)} \x1B ");
    log.green("------ Current StatusCode ------");
    log.green(
        "--🧚🧚🧚🧚🧚🧚🧚 \x1B ${jsonEncode(response.statusCode)} \x1B ---");
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.cyan("------ Current Request Parameters Data -----");
    log.cyan("${options.queryParameters}");
    log.yellow("------ Current Request Headers -----");
    log.yellow("${options.headers}");
    log.green("------ Current Request Path -----");
    log.green(
        "${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}");
    return super.onRequest(options, handler);
  }
  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   log.red("\x1B[37m------ Current Error Response -----\x1B[0m");
  //   log.red("\x1B[31m${err.response?.data}\x1B[0m");
  //   log.red("\x1B[37m------ Current Error StatusCode -----\x1B[0m");
  //   log.red("\x1B[31m${err.response?.statusCode}\x1B[0m");
  //   final options = err.requestOptions;
  //   log.red(options.method); // Debug log
  //   log.red('Error: ${err.error}, Message: ${err.message}');
  //   // push(NamedRoutes.i.sign_in);
  //   // showErrorDialogue("not find");
  //   return super.onError(err, handler);
  // }
  //
  // @override
  // Future<void> onResponse(
  //     Response response, ResponseInterceptorHandler handler) async {
  //   log.green("------ Current Response ------");
  //   log.green(jsonEncode(response.data));
  //   log.green("------ Current StatusCode ------");
  //   log.green(jsonEncode(response.statusCode));
  //   return super.onResponse(response, handler);
  // }
  //
  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   log.cyan('====================START====================');
  //   log.cyan('HTTP method => ${options.method} ');
  //   log.cyan(
  //       'Request => ${options.baseUrl}${options.path}${options.queryParameters}');
  //   log.cyan('Header  => ${options.headers}');
  //   log.cyan("------ Current Request Parameters Data -----");
  //   log.cyan("${options.queryParameters}");
  //   log.yellow("------ Current Request Headers -----");
  //   log.yellow("${options.headers}");
  //   log.green("------ Current Request Path -----");
  //   log.green('HTTP method => ${options.method} ');
  //   log.green(
  //       'Request => ${options.baseUrl}${options.path}${options.queryParameters}');
  //   log.green('Header  => ${options.headers}');
  //   log.green(
  //       "${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}");
  //   return super.onRequest(options, handler);
  // }
}
