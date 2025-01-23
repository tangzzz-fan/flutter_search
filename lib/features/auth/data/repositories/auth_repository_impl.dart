import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<AuthFailure, User>> login(String email, String password) async {
    try {
      final user = await dataSource.login(email, password);
      return Right(user);
    } catch (e) {
      if (e.toString().contains('Invalid credentials')) {
        return const Left(InvalidCredentialsFailure());
      }
      if (e.toString().contains('Network')) {
        return const Left(NetworkFailure());
      }
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> logout() async {
    try {
      await dataSource.logout();
      return const Right(unit);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<AuthFailure, User>> getCurrentUser() async {
    try {
      final user = await dataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
