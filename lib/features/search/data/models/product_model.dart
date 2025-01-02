// lib/features/search/data/models/product_model.dart
class ProductModel {
  final String id;
  final String name;

  ProductModel({required this.id, required this.name});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
