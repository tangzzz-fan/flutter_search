import 'package:dartz/dartz.dart';
import '../entities/article.dart';
import '../failures/article_failure.dart';

abstract class ArticleRepository {
  Future<Either<ArticleFailure, List<Article>>> getArticles();
  Future<Either<ArticleFailure, Article>> getArticle(int id);
}
