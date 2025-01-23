abstract class ArticleFailure {
  final String message;
  const ArticleFailure(this.message);
}

class NetworkFailure extends ArticleFailure {
  const NetworkFailure(String message) : super(message);
}

class ServerFailure extends ArticleFailure {
  const ServerFailure(String message) : super(message);
}
