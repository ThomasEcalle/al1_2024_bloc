part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

class AddProduct extends CartEvent {
  final Product product;

  const AddProduct({required this.product});
}

class RemoveProduct extends CartEvent {
  final Product product;

  const RemoveProduct({required this.product});
}

class ClearCart extends CartEvent {}
