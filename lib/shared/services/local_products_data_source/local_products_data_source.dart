import '../../models/product.dart';
import '../products_data_source/products_data_source.dart';

abstract class LocalProductsDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts();

  Future<void> saveProducts(List<Product> products);
}
