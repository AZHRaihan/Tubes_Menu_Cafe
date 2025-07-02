import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CartProvider extends ChangeNotifier {
  // Key: MenuItem, Value: jumlah
  final Map<MenuItem, int> _items = {};

  Map<MenuItem, int> get items => Map.unmodifiable(_items);

  /// Tambah 1 pcs. Jika sudah ada, jumlah bertambah.
  void addItem(MenuItem item) {
    _items.update(item, (qty) => qty + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  /// Kurangi 1 pcs; hapus jika qty jadi 0.
  void removeSingle(MenuItem item) {
    if (!_items.containsKey(item)) return;
    final currentQty = _items[item]!;
    if (currentQty > 1) {
      _items[item] = currentQty - 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  /// Hapus item sepenuhnya.
  void removeItem(MenuItem item) {
    _items.remove(item);
    notifyListeners();
  }

  /// Hitung total harga seluruh item.
  double get totalPrice =>
      _items.entries.fold(0, (sum, e) => sum + (e.key.price * e.value));

  /// Hitung total jumlah item (untuk badge ikon keranjang).
  int get totalQty => _items.values.fold(0, (sum, qty) => sum + qty);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
