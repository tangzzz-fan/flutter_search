import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/api_data_source_impl.dart';
import '../../data/repositories/api_repository_impl.dart';
import '../../domain/repositories/api_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio()
    ..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
});

final apiDataSourceProvider = Provider<ApiDataSourceImpl>((ref) {
  return ApiDataSourceImpl(dio: ref.watch(dioProvider));
});

final apiRepositoryProvider = Provider<ApiRepository>((ref) {
  return ApiRepositoryImpl(dataSource: ref.watch(apiDataSourceProvider));
});

final postsProvider = FutureProvider((ref) {
  return ref.watch(apiRepositoryProvider).getPosts();
});
