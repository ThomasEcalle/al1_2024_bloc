import '../../models/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getAllProducts();
}
