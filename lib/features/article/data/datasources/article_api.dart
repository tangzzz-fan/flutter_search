import 'package:dio/dio.dart';
import '../models/article_model.dart';

abstract class ArticleApi {
  Future<List<ArticleModel>> getArticles();
  Future<ArticleModel> getArticle(int id);
}

class ArticleApiImpl implements ArticleApi {
  final Dio dio;
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  ArticleApiImpl({required this.dio});

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      final response = await dio.get('$baseUrl/posts');
      return (response.data as List)
          .map((json) => ArticleModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch articles');
    }
  }

  @override
  Future<ArticleModel> getArticle(int id) async {
    try {
      final response = await dio.get('$baseUrl/posts/$id');
      return ArticleModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch article');
    }
  }
}
