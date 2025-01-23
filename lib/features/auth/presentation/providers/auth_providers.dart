import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_data_source_impl.dart';

// 数据源提供者
final authDataSourceProvider = Provider((ref) => AuthDataSourceImpl());

// 仓库提供者
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authDataSourceProvider));
});

// 认证状态提供者
final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<Either<AuthFailure, User?>>>(
        (ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier
    extends StateNotifier<AsyncValue<Either<AuthFailure, User?>>> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AsyncValue.data(Right(null))) {
    _init();
  }

  Future<void> _init() async {
    state = const AsyncValue.loading();
    final result = await _repository.getCurrentUser();
    state = AsyncValue.data(result);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await _repository.login(email, password);
    state = AsyncValue.data(result);
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final result = await _repository.logout();
    state = AsyncValue.data(result.fold(
      (failure) => Left(failure),
      (_) => const Right(null),
    ));
  }
}
