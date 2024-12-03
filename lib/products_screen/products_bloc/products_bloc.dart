import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../app_exception.dart';
import '../../shared/models/product.dart';
import '../../shared/services/products_repository/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;

  ProductsBloc({required this.productsRepository}) : super(const ProductsState()) {
    on<GetAllProducts>((event, emit) async {
      final filter = event.filter;
      emit(state.copyWith(status: ProductsStatus.loading));

      try {
        final products = await productsRepository.getAllProducts();
        emit(state.copyWith(
          products: products,
          status: ProductsStatus.success,
        ));
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: ProductsStatus.error,
          exception: appException,
        ));
      }
    });
  }
}
