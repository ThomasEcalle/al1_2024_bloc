import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/blocs/cart_bloc/cart_bloc.dart';
import '../../shared/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static Future<void> navigateTo(BuildContext context, Product product) {
    return Navigator.pushNamed(context, 'productDetail', arguments: product);
  }

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ''),
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final addingToCart = state.status == CartStatus.addingCart;
          final removingFromCart = state.status == CartStatus.removingCart;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'removingFromCart',
                child: switch (removingFromCart) {
                  true => const CircularProgressIndicator(),
                  false => const Icon(Icons.remove_shopping_cart),
                },
                onPressed: () => _onRemoveFromShoppingCart(context),
              ),
              const SizedBox(height: 20),
              FloatingActionButton(
                heroTag: 'addingToCart',
                child: switch (addingToCart) {
                  true => const CircularProgressIndicator(),
                  false => const Icon(Icons.add_shopping_cart),
                },
                onPressed: () => _onAddToShoppingCart(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onAddToShoppingCart(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    //final cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(AddProduct(product: product));
  }

  void _onRemoveFromShoppingCart(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(RemoveProduct(product: product));
  }
}
