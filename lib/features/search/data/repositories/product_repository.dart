// lib/features/search/data/repositories/product_repository.dart
import '../data_sources/product_data_source.dart';
import '../models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    return await dataSource.fetchProducts(query);
  }
}
