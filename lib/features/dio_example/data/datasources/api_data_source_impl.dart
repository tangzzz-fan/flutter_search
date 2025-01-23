import 'package:dio/dio.dart';
import '../../domain/entities/post.dart';
import './api_data_source.dart';

class ApiDataSourceImpl implements ApiDataSource {
  final Dio dio;
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  ApiDataSourceImpl({required this.dio});

  @override
  Future<List<Post>> getPosts() async {
    try {
      final response = await dio.get('$baseUrl/posts');
      return (response.data as List)
          .map((json) => Post.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }

  @override
  Future<Post> getPost(int id) async {
    try {
      final response = await dio.get('$baseUrl/posts/$id');
      return Post.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch post');
    }
  }

  @override
  Future<Post> createPost(Post post) async {
    try {
      final response = await dio.post(
        '$baseUrl/posts',
        data: post.toJson(),
      );
      return Post.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create post');
    }
  }

  @override
  Future<Post> updatePost(Post post) async {
    try {
      final response = await dio.put(
        '$baseUrl/posts/${post.id}',
        data: post.toJson(),
      );
      return Post.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update post');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      await dio.delete('$baseUrl/posts/$id');
    } catch (e) {
      throw Exception('Failed to delete post');
    }
  }
}
