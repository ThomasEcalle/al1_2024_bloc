import 'package:al1_2024_bloc/shared/models/product.dart';

import 'products_data_source.dart';

class FakeDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(10, (index) {
      return Product(
        id: index,
        title: 'titre $index',
        price: 2.0,
      );
    });
  }
}
