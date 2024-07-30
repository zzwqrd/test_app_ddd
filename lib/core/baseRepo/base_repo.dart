import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../network/dio_client.dart';
import '../network/exceptions/exceptions.dart';
import '../network/exceptions/failures.dart';

abstract class NetworkService {
  final DioClient dioHelper = DioClient.instance;

  Future<Either<Failure, ReturnType>> exceptionHandler<ReturnType>(
      Future<ReturnType> Function() function) async {
    try {
      return Right(await function());
    } catch (e, trace) {
      if (kDebugMode) {
        print(e.toString());
        print(trace.toString());
      }

      if (e is ServerException) {
        return Left(
            ServerFailure(message: e.toString(), statusCode: e.statusCode));
      } else {
        return Left(ServerFailure(
            message: "Something went wrong, please try again later.",
            statusCode: 500));
      }
    }
  }
}
