import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/blocs/cart_bloc/cart_bloc.dart';
import 'widgets/cart_list_item.dart';

class CartScreen extends StatelessWidget {
  static Future<void> navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, '/cartScreen');
  }

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon panier !'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          print('Building cart screen list');
          final products = state.products;
          if (products.isEmpty) return _buildEmptyCart(context);
          return ListView.separated(
            itemCount: products.keys.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final product = products.keys.elementAt(index);
              final quantity = products[product];
              return CartListItem(
                product: product,
                quantity: quantity ?? 0,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Votre panier est vide'),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }
}
