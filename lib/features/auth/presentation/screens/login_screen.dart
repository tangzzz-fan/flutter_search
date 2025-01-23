import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search/features/auth/domain/entities/user.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: authState.when(
          data: (userOrFailure) => userOrFailure.fold(
            (failure) => _buildLoginForm(context, ref, failure.message),
            (user) => user == null
                ? _buildLoginForm(context, ref, null)
                : _buildUserInfo(context, ref, user),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildLoginForm(
      BuildContext context, WidgetRef ref, String? errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'test@example.com',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            hintText: 'password',
          ),
          obscureText: true,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            ref.read(authStateProvider.notifier).login(
                  _emailController.text,
                  _passwordController.text,
                );
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, WidgetRef ref, User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome, ${user.name}!'),
        const SizedBox(height: 16),
        Text('Email: ${user.email}'),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => ref.read(authStateProvider.notifier).logout(),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
