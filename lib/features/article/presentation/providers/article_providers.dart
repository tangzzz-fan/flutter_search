import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search/features/article/data/datasources/article_api.dart';
import 'package:flutter_search/features/article/domain/entities/article.dart';
import '../../data/datasources/mock_article_api.dart';
import '../../data/repositories/article_repository_impl.dart';
import '../../domain/repositories/article_repository.dart';

final articleDioProvider = Provider<Dio>((ref) {
  return Dio()
    ..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
});

final articleApiProvider = Provider<ArticleApi>((ref) {
  return MockArticleApi();
});

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepositoryImpl(api: ref.watch(articleApiProvider));
});

final articlesProvider = FutureProvider((ref) {
  return ref.watch(articleRepositoryProvider).getArticles();
});

final articleProvider = FutureProvider.family<Article, int>((ref, id) async {
  final result = await ref.watch(articleRepositoryProvider).getArticle(id);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (article) => article,
  );
});
