// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants.dart';
import 'core/theme.dart';
import 'routes/app_route.dart';
import 'package:tubes_menu_cafe/db/database_helper.dart';
import 'providers/auth_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/cart_provider.dart';

void main() async {
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

        // ── MenuProvider memuat data dari SQLite
        ChangeNotifierProvider(
          create: (_) {
            final prov = MenuProvider();
            prov.loadMenu(); // ⬅️  panggil sekali
            return prov;
          },
        ),

        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: AppTheme.lightTheme,
          initialRoute: auth.isLoggedIn ? '/dashboard' : '/login',
          routes: AppRouter.routes,
          // onGenerateRoute: AppRouter.onGenerateRoute, // opsional
        ),
      ),
    );
  }
}
