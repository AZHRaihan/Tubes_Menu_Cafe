import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser; // null = belum login

  bool get isLoggedIn => _currentUser != null;
  User? get user => _currentUser;

  /// Dummy login: apa pun kombinasi email & password dianggap sukses.
  Future<void> login({
    required String name,
    required String email,
    required String phone,
  }) async {
    _currentUser = User(name: name, email: email, phone: phone);
    notifyListeners();
  }

  /// Update profil pengguna (di halaman Profile).
  void updateProfile({required String name, required String phone}) {
    if (_currentUser == null) return;
    _currentUser!
      ..name = name
      ..phone = phone;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
