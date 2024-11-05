import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_exception.dart';
import '../cart_screen/cart_screen.dart';
import '../shared/blocs/cart_bloc/cart_bloc.dart';
import '../shared/models/product.dart';
import 'product_detail_screen/product_detail_screen.dart';
import 'products_bloc/products_bloc.dart';
import 'widgets/cart_icon.dart';
import 'widgets/product_list_item.dart';

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
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if(state.status == CartStatus.errorAddingCart) {
          _showSnackBar(context, state.exception);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Produits'),
          actions: [
            BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) {
                final addingOrRemovingCart =
                    current.status == CartStatus.addingCart || current.status == CartStatus.removingCart;
                return !addingOrRemovingCart;
              },
              builder: (context, state) {
                return CartIcon(
                  onTap: () => _openCartScreen(context),
                  quantity: state.getNbProductsInCart(),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            return switch (state.status) {
              ProductsStatus.initial || ProductsStatus.loading => _buildLoading(context),
              ProductsStatus.error => _buildError(context, state.exception),
              ProductsStatus.success => _buildSuccess(context, state.products),
            };
          },
        ),
      ),
    );
  }

  void _getAllProducts() {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(const GetAllProducts(''));
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, AppException? exception) {
    return Center(
      child: Text('Oups, une erreur est survenur: $exception'),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Product> products) {
    return RefreshIndicator(
      onRefresh: () async => _getAllProducts(),
      child: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductListItem(
            product: product,
            onTap: () => _openProductDetailScreen(context, product),
          );
        },
      ),
    );
  }

  void _openProductDetailScreen(BuildContext context, Product product) {
    ProductDetailScreen.navigateTo(context, product);
  }

  void _openCartScreen(BuildContext context) {
    CartScreen.navigateTo(context);
  }

  void _showSnackBar(BuildContext context, AppException? exception) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de l\'ajout du produit dans le panier: ${exception}'),
      ),
    );
  }
}
