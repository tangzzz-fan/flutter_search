// lib/features/search/presentation/widgets/search_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search/features/search/data/data_sources/product_data_source.dart';
import 'package:flutter_search/features/search/data/models/product_model.dart';
import 'package:flutter_search/features/search/data/repositories/product_repository.dart';
import 'package:flutter_search/features/search/domain/use_cases/search_products.dart';

final searchProvider = StateProvider<String>((ref) => '');
final productsProvider = FutureProvider<List<ProductModel>>((ref) {
  final query = ref.watch(searchProvider);
  final repository = ref.watch(productRepositoryProvider);
  return SearchProducts(repository).call(query);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ProductDataSource());
});

class SearchWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('搜索产品')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              // 使用 notifier 更新状态
              ref.read(searchProvider.notifier).state = value;
            },
            decoration: InputDecoration(labelText: '输入产品名称'),
          ),
          Expanded(
            child: productsAsyncValue.when(
              data: (products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(products[index].name));
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('错误：$error')),
            ),
          ),
        ],
      ),
    );
  }
}
