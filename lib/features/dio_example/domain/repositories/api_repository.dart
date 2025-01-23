import 'package:dartz/dartz.dart';
import '../entities/post.dart';
import '../failures/api_failure.dart';

abstract class ApiRepository {
  Future<Either<ApiFailure, List<Post>>> getPosts();
  Future<Either<ApiFailure, Post>> getPost(int id);
  Future<Either<ApiFailure, Post>> createPost(Post post);
  Future<Either<ApiFailure, Post>> updatePost(Post post);
  Future<Either<ApiFailure, Unit>> deletePost(int id);
}
