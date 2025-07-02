import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_menu_cafe/models/menu_item.dart';
import 'package:tubes_menu_cafe/providers/cart_provider.dart';
import 'package:tubes_menu_cafe/core/constants.dart';

class MenuCard extends StatelessWidget {
  final MenuItem item;

  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: ListTile(
        leading: Image.asset(item.image, width: 50),
        title: Text(item.name),
        subtitle: Text("Rp ${item.price.toStringAsFixed(0)}"),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            context.read<CartProvider>().addItem(item);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${item.name} ditambahkan ke keranjang")),
            );
          },
        ),
      ),
    );
  }
}
