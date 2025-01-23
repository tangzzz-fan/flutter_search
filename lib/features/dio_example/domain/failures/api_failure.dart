abstract class ApiFailure {
  final String message;
  const ApiFailure(this.message);
}

class NetworkFailure extends ApiFailure {
  const NetworkFailure(String message) : super(message);
}

class ServerFailure extends ApiFailure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends ApiFailure {
  const CacheFailure(String message) : super(message);
}
