import 'package:flutter/material.dart';

import '../../shared/models/product.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.product,
    this.onTap,
  });

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      onTap: onTap,
    );
  }
}
