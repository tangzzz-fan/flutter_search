import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../failures/auth_failure.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, User>> login(String email, String password);
  Future<Either<AuthFailure, Unit>> logout();
  Future<Either<AuthFailure, User>> getCurrentUser();
}
