import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_menu_cafe/core/constants.dart';
import 'package:tubes_menu_cafe/providers/auth_provider.dart';
import 'package:tubes_menu_cafe/widgets/offer_banner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0; // 0 = home, 1 = menu, 2 = history

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final greeting = user == null
        ? 'Selamat datang!'
        : 'Hai, ${user.name.split(' ').first} 👋';

    // ── Body tampilan Home (index 0)
    Widget homeBody() => SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sapaan
          Text(
            greeting,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text("Mau pesan apa hari ini?", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 24),

          // Promo banner horizontal
          Text(
            "Promo Minggu Ini",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                OfferBanner(text: 'Diskon 10% Cappuccino!'),
                OfferBanner(text: 'Gratis Kentang Goreng'),
                OfferBanner(text: 'Voucher Rp10.000!'),
              ],
            ),
          ),
        ],
      ),
    );

    // ── Tentukan body sesuai tab
    Widget body;
    if (_currentIndex == 1) {
      // Langsung redirect ke menu & reset index ke 0
      Future.microtask(() {
        setState(() => _currentIndex = 0);
        Navigator.pushNamed(context, '/menu');
      });
      body = const SizedBox.shrink();
    } else if (_currentIndex == 2) {
      Future.microtask(() {
        setState(() => _currentIndex = 0);
        Navigator.pushNamed(context, '/history');
      });
      body = const SizedBox.shrink();
    } else {
      body = homeBody();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe De.Vini'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profil Saya',
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: body,

      // ───────────────────────────── Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
