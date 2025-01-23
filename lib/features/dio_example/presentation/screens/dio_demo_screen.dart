import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dio_provider.dart';
import '../../domain/entities/post.dart';

class DioDemoScreen extends ConsumerWidget {
  const DioDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Demo'),
      ),
      body: postsAsync.when(
        data: (postsEither) => postsEither.fold(
          (failure) => Center(
            child: Text('Error: ${failure.message}'),
          ),
          (posts) => ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                onTap: () => _showPostDetails(context, post),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showPostDetails(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(post.title),
        content: Text(post.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('创建新帖子'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: '标题'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: '内容'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final post = Post(
                title: titleController.text,
                body: bodyController.text,
                userId: 1,
              );
              ref.read(apiRepositoryProvider).createPost(post);
              Navigator.pop(context);
              ref.refresh(postsProvider);
            },
            child: const Text('创建'),
          ),
        ],
      ),
    );
  }
}
