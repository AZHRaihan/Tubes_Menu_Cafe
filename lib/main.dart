// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants.dart'; // ← tambahkan
import 'core/theme.dart';
import 'routes/app_route.dart'; // ← tambahkan

import 'providers/auth_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/cart_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyCafeApp());
}

class MyCafeApp extends StatelessWidget {
  const MyCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          // ← PASTIKAN return MaterialApp
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.lightTheme,
            initialRoute: auth.isLoggedIn ? '/dashboard' : '/login',
            routes: AppRouter.routes,
            // onGenerateRoute: AppRouter.onGenerateRoute, // (opsional)
          );
        },
      ),
    );
  }
}
