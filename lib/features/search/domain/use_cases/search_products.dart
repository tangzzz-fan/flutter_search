// lib/features/search/domain/use_cases/search_products.dart

import 'package:flutter_search/features/search/data/models/product_model.dart';
import 'package:flutter_search/features/search/data/repositories/product_repository.dart';

class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<ProductModel>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
