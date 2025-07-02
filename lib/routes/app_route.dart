// lib/routes/app_router.dart
import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/history/history_screen.dart';

/// Kelas statis untuk menangani semua rute aplikasi.
/// - [routes]      → Map<String, WidgetBuilder> jika ingin langsung dipasang ke `routes:`
/// - [onGenerateRoute] → Fallback ketika rute tidak ditemukan (dipakai di `onGenerateRoute:`)
class AppRouter {
  // Map rute utama — cukup pasang di MaterialApp.routes
  static Map<String, WidgetBuilder> get routes => {
    '/login': (_) => const LoginScreen(),
    '/dashboard': (_) => const DashboardScreen(),
    '/menu': (_) => const MenuScreen(),
    '/cart': (_) => const CartScreen(),
    '/profile': (_) => const ProfileScreen(),
    '/receipt': (_) => const Placeholder(),
    '/history': (_) => const HistoryScreen(),
  };

  // Fallback generator — optional (mis. ketika pakai pushNamed yg typo)
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return _page(const LoginScreen());
      case '/dashboard':
        return _page(const DashboardScreen());
      case '/menu':
        return _page(const MenuScreen());
      case '/cart':
        return _page(const CartScreen());
      case '/profile':
        return _page(const ProfileScreen());
      default:
        // Jika rute tak dikenal, arahkan ke /login
        return _page(const LoginScreen());
    }
  }

  /// Helper privat untuk konsistensi transition
  static MaterialPageRoute<T> _page<T>(Widget child) =>
      MaterialPageRoute<T>(builder: (_) => child);
}
