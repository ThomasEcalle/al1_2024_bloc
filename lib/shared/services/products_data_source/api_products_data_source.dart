import 'package:al1_2024_bloc/shared/models/product.dart';
import 'package:dio/dio.dart';

import 'products_data_source.dart';

class ApiProductsDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    final response = await Dio().get('https://dummyjson.com/products');
    final jsonList = response.data['products'] as List;
    return jsonList.map((jsonElement) => Product.fromJson(jsonElement)).toList();
  }
}
