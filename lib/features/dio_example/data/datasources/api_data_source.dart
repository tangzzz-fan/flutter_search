import '../../domain/entities/post.dart';

abstract class ApiDataSource {
  Future<List<Post>> getPosts();
  Future<Post> getPost(int id);
  Future<Post> createPost(Post post);
  Future<Post> updatePost(Post post);
  Future<void> deletePost(int id);
}
