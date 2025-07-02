import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tubes_menu_cafe/providers/menu_provider.dart';
import 'package:tubes_menu_cafe/providers/cart_provider.dart';
import 'package:tubes_menu_cafe/models/menu_item.dart';
import 'package:tubes_menu_cafe/core/constants.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _bottomIndex = 1; // 0 = Home, 1 = Menu (aktif), 2 = History
  int _tabIndex = 0; // 0 = food, 1 = drink

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return DefaultTabController(
      length: 2,
      initialIndex: _tabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu Café'),
          bottom: TabBar(
            onTap: (i) => setState(() => _tabIndex = i),
            labelColor: AppConstants.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppConstants.primaryColor,
            tabs: const [
              Tab(text: 'Makanan'),
              Tab(text: 'Minuman'),
            ],
          ),
        ),

        // ---------- Body (TabBarView)
        body: TabBarView(
          children: [
            _MenuList(category: 'food'),
            _MenuList(category: 'drink'),
          ],
        ),

        // ---------- Keranjang
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, '/cart'),
          icon: const Icon(Icons.shopping_cart),
          label: Text('Keranjang (${cartProvider.totalQty})'),
        ),

        // ---------- Bottom Navigation Bar (sama seperti Dashboard)
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomIndex,
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            if (index == _bottomIndex) return;
            setState(() => _bottomIndex = index);

            // Navigasi sesuai indeks
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/dashboard');
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, '/history');
            }
            // index 1 = Menu, tetap di halaman ini
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}

//───────────────────────────────────────────────────────────────
//                       LIST PER KATEGORI
//───────────────────────────────────────────────────────────────
class _MenuList extends StatelessWidget {
  final String category;
  const _MenuList({required this.category});

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();
    final List<MenuItem> menu = menuProvider.menuByCategory(category);

    if (menu.isEmpty) {
      return const Center(child: Text('Belum ada item.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: menu.length,
      itemBuilder: (_, i) => _MenuCard(item: menu[i]),
    );
  }
}

//───────────────────────────────────────────────────────────────
//                       KARTU MENU
//───────────────────────────────────────────────────────────────
class _MenuCard extends StatelessWidget {
  final MenuItem item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.image,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp ${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CartProvider>().addItem(item);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.name} ditambahkan')),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
