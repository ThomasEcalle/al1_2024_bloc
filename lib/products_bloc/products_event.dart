part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {
  const ProductsEvent();
}

class GetAllProducts extends ProductsEvent {
  final String filter;

  const GetAllProducts(this.filter);
}
