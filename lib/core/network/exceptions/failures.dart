abstract class Failure {
  String? message;
  int? statusCode;
  Failure({this.message, this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({
    super.message,
    super.statusCode,
  });
}

class NotFoundFailure extends Failure {
  final String message;
  final int statusCode;

  NotFoundFailure({required this.message, required this.statusCode});
}

class ClientFailure extends Failure {
  ClientFailure({
    super.message,
    super.statusCode,
  });
}
