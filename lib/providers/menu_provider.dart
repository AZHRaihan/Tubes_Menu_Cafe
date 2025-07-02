import 'package:flutter/material.dart';
import 'package:tubes_menu_cafe/models/menu_item.dart';
import 'package:tubes_menu_cafe/db/database_helper.dart';

class MenuProvider extends ChangeNotifier {
  final List<MenuItem> _menu = [];

  List<MenuItem> get allMenu => List.unmodifiable(_menu);

  /// Ambil menu per kategori
  List<MenuItem> menuByCategory(String category) =>
      _menu.where((m) => m.category == category).toList();

  //───────────────────────────────  INITIAL LOAD
  Future<void> loadMenu() async {
    final data = await DatabaseHelper.instance.getAllMenu();

    // Jika DB kosong, seed data awal
    if (data.isEmpty) {
      await _seedSampleData();
    }

    _menu
      ..clear()
      ..addAll(
        data.map(
          (e) => MenuItem(
            id: e['id'] as String,
            name: e['name'] as String,
            category: e['category'] as String,
            price: (e['price'] as num).toDouble(),
            image: e['image'] as String,
          ),
        ),
      );
    notifyListeners();
  }

  //───────────────────────────────  ADD menu (opsional)
  Future<void> addMenuItem(MenuItem item) async {
    await DatabaseHelper.instance.insertMenu({
      'id': item.id,
      'name': item.name,
      'category': item.category,
      'price': item.price,
      'image': item.image,
    });
    _menu.add(item);
    notifyListeners();
  }

  //───────────────────────────────  SEED DUMMY DATA
  Future<void> _seedSampleData() async {
    const dummy = [
      MenuItem(
        id: 'm1',
        name: 'Cappuccino',
        category: 'drink',
        price: 28000,
        image: 'assets/images/cappucino.jpeg',
      ),
      MenuItem(
        id: 'm2',
        name: 'Latte',
        category: 'drink',
        price: 30000,
        image: 'assets/images/latte.jpeg',
      ),
      MenuItem(
        id: 'm3',
        name: 'Cheese Burger',
        category: 'food',
        price: 45000,
        image: 'assets/images/burger.jpeg',
      ),
      MenuItem(
        id: 'm4',
        name: 'French Fries',
        category: 'food',
        price: 22000,
        image: 'assets/images/fries.jpeg',
      ),
    ];

    for (final item in dummy) {
      await addMenuItem(item);
    }
  }
}
