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

class ClientFailure extends Failure {
  ClientFailure({
    super.message,
    super.statusCode,
  });
}
