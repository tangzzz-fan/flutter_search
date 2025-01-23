import 'package:dartz/dartz.dart';
import '../../domain/entities/article.dart';
import '../../domain/failures/article_failure.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/article_api.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleApi api;

  ArticleRepositoryImpl({required this.api});

  @override
  Future<Either<ArticleFailure, List<Article>>> getArticles() async {
    try {
      final articles = await api.getArticles();
      return Right(articles);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<ArticleFailure, Article>> getArticle(int id) async {
    try {
      final article = await api.getArticle(id);
      return Right(article);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
