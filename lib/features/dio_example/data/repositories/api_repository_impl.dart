import 'package:dartz/dartz.dart';
import '../../domain/entities/post.dart';
import '../../domain/failures/api_failure.dart';
import '../../domain/repositories/api_repository.dart';
import '../datasources/api_data_source.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiDataSource dataSource;

  ApiRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ApiFailure, List<Post>>> getPosts() async {
    try {
      final posts = await dataSource.getPosts();
      return Right(posts);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, Post>> getPost(int id) async {
    try {
      final post = await dataSource.getPost(id);
      return Right(post);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, Post>> createPost(Post post) async {
    try {
      final createdPost = await dataSource.createPost(post);
      return Right(createdPost);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, Post>> updatePost(Post post) async {
    try {
      final updatedPost = await dataSource.updatePost(post);
      return Right(updatedPost);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, Unit>> deletePost(int id) async {
    try {
      await dataSource.deletePost(id);
      return const Right(unit);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
