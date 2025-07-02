import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuProvider extends ChangeNotifier {
  final List<MenuItem> _allMenu = [
    const MenuItem(
      id: 'm1',
      name: 'Cappuccino',
      category: 'drink',
      price: 28000,
      image: 'assets/images/cappucino.jpeg',
    ),
    const MenuItem(
      id: 'm2',
      name: 'Latte',
      category: 'drink',
      price: 30000,
      image: 'assets/images/latte.jpeg',
    ),
    const MenuItem(
      id: 'm3',
      name: 'Cheese Burger',
      category: 'food',
      price: 45000,
      image: 'assets/images/burger.jpeg',
    ),
    const MenuItem(
      id: 'm4',
      name: 'French Fries',
      category: 'food',
      price: 22000,
      image: 'assets/images/fries.jpeg',
    ),
  ];

  List<MenuItem> get allMenu => List.unmodifiable(_allMenu);

  /// Ambil menu per kategori.
  List<MenuItem> menuByCategory(String category) =>
      _allMenu.where((m) => m.category == category).toList();
}
