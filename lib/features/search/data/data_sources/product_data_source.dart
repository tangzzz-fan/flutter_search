// lib/features/search/data/data_sources/product_data_source.dart
import '../models/product_model.dart';

class ProductDataSource {
  Future<List<ProductModel>> fetchProducts(String query) async {
    // 模拟 API 调用，返回匹配的产品列表
    await Future.delayed(Duration(seconds: 1)); // 模拟延迟
    return [
      ProductModel(id: '1', name: 'Apple'),
      ProductModel(id: '2', name: 'Banana'),
      ProductModel(id: '3', name: 'Cherry'),
    ].where((product) => product.name.contains(query)).toList();
  }
}
