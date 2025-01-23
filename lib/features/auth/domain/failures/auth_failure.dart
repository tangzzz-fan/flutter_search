abstract class AuthFailure {
  final String message;
  const AuthFailure(this.message);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super('Invalid email or password');
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure() : super('Network error occurred');
}

class ServerFailure extends AuthFailure {
  const ServerFailure() : super('Server error occurred');
}
