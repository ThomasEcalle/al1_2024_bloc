import '../../models/product.dart';
import '../local_products_data_source/local_products_data_source.dart';
import '../products_data_source/products_data_source.dart';

class ProductsRepository {
  final ProductsDataSource remoteDataSource;
  final LocalProductsDataSource localProductsDataSource;

  ProductsRepository({
    required this.remoteDataSource,
    required this.localProductsDataSource,
  });

  Future<List<Product>> getAllProducts() async {
    try {
      final products = await remoteDataSource.getAllProducts();
      localProductsDataSource.saveProducts(products);
      return products;
    } catch (error) {
      return localProductsDataSource.getAllProducts();
    }
  }
}
