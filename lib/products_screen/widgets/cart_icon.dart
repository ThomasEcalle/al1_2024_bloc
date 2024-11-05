import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
    this.onTap,
    required this.quantity,
  });

  final VoidCallback? onTap;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    print('Building cart icon');
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$quantity'),
          const SizedBox(width: 8),
          const Icon(Icons.shopping_cart),
        ],
      ),
    );
  }
}
