import '../../domain/entities/user.dart';
import './auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  User? _currentUser;

  @override
  Future<User> login(String email, String password) async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'test@example.com' && password == 'password') {
      _currentUser = User(
        id: '1',
        email: email,
        name: 'Test User',
      );
      return _currentUser!;
    }

    throw Exception('Invalid credentials');
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = null;
  }

  @override
  Future<User> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_currentUser != null) {
      return _currentUser!;
    }
    throw Exception('No user logged in');
  }
}
