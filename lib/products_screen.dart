import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products_bloc/products_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    _getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final products = state.products;
          return RefreshIndicator(
            onRefresh: () async => _getAllProducts(),
            child: ListView.separated(
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.title),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _getAllProducts() {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(const GetAllProducts(''));
  }
}
