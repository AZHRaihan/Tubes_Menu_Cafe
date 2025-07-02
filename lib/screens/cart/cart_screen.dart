import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_menu_cafe/providers/cart_provider.dart';
import 'package:tubes_menu_cafe/models/menu_item.dart';
import 'package:tubes_menu_cafe/core/constants.dart';
import 'package:tubes_menu_cafe/screens/receipt/receipt_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Saya")),
      body: cart.items.isEmpty
          ? const _EmptyCart()
          : Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: cart.items.entries
                          .map(
                            (entry) => _CartItemCard(
                              item: entry.key,
                              qty: entry.value,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _CartTotal(
                    total: cart.totalPrice,
                    onPayPressed: () {
                      final itemsSnapshot = Map<MenuItem, int>.from(cart.items);
                      final totalSnapshot = cart.totalPrice;
                      cart.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReceiptScreen(
                            items: itemsSnapshot,
                            total: totalSnapshot,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

//───────────────────────────────────────────────────────────────
// KARTU ITEM BELANJA
//───────────────────────────────────────────────────────────────
class _CartItemCard extends StatelessWidget {
  final MenuItem item;
  final int qty;

  const _CartItemCard({required this.item, required this.qty});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            item.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(item.name),
        subtitle: Text('Rp ${item.price.toStringAsFixed(0)} x $qty'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => cart.removeItem(item),
        ),
      ),
    );
  }
}

//───────────────────────────────────────────────────────────────
// TOTAL DAN TOMBOL BAYAR
//───────────────────────────────────────────────────────────────
class _CartTotal extends StatelessWidget {
  final double total;
  final VoidCallback onPayPressed;

  const _CartTotal({required this.total, required this.onPayPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: Theme.of(context).textTheme.titleMedium),
            Text(
              'Rp ${total.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppConstants.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onPayPressed,
          icon: const Icon(Icons.payment),
          label: const Text("Bayar di Kasir"),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            backgroundColor: AppConstants.primaryColor,
          ),
        ),
      ],
    );
  }
}

//───────────────────────────────────────────────────────────────
// HALAMAN KETIKA KERANJANG KOSONG
//───────────────────────────────────────────────────────────────
class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "Keranjang masih kosong",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "Yuk, pilih menu favoritmu dulu!",
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/menu'),
              icon: const Icon(Icons.restaurant_menu),
              label: const Text("Lihat Menu"),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
