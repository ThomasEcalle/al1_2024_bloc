import 'package:al1_2024_bloc/shared/models/product.dart';

import 'local_products_data_source.dart';

class FakeLocalProductsDataSource extends LocalProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    return [];
  }

  @override
  Future<void> saveProducts(List<Product> products) async {
    return;
  }
}
