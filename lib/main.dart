import 'package:al1_2024_bloc/products_screen/products_bloc/products_bloc.dart';
import 'package:al1_2024_bloc/products_screen/products_screen.dart';
import 'package:al1_2024_bloc/shared/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen/cart_screen.dart';
import 'products_screen/product_detail_screen/product_detail_screen.dart';
import 'shared/blocs/cart_bloc/cart_bloc.dart';
import 'shared/services/local_products_data_source/fake_local_products_data_source.dart';
import 'shared/services/products_data_source/fake_data_source.dart';
import 'shared/services/products_repository/products_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductsRepository(
        remoteDataSource: FakeDataSource(),
        localProductsDataSource: FakeLocalProductsDataSource(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsBloc(
              productsRepository: context.read<ProductsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const ProductsScreen(),
            '/cartScreen': (context) => const CartScreen(),
          },
          onGenerateRoute: (routeSettings) {
            Widget screen = Container(color: Colors.pink);
            final argument = routeSettings.arguments;
            switch (routeSettings.name) {
              case 'productDetail':
                if (argument is Product) {
                  screen = ProductDetailScreen(product: argument);
                }
                break;
            }

            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}
