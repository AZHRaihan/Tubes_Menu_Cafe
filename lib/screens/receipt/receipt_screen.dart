import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../models/menu_item.dart';
import '../../core/constants.dart';

class ReceiptScreen extends StatelessWidget {
  final Map<MenuItem, int> items;
  final double total;

  const ReceiptScreen({super.key, required this.items, required this.total});

  String _buildReceiptText() {
    final now = DateTime.now();
    final dateStr =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} "
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    final buffer = StringBuffer()
      ..writeln("MY CAFÉ")
      ..writeln("Tanggal : $dateStr")
      ..writeln("--------------------------------");

    for (var e in items.entries) {
      final lineTotal = (e.key.price * e.value).toStringAsFixed(0);
      buffer.writeln("${e.key.name} x${e.value}  Rp $lineTotal");
    }

    buffer
      ..writeln("--------------------------------")
      ..writeln("TOTAL : Rp ${total.toStringAsFixed(0)}")
      ..writeln("--------------------------------")
      ..writeln("Terima kasih!");

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final receiptText = _buildReceiptText();

    return Scaffold(
      appBar: AppBar(title: const Text("Struk Belanja")),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teks struk
            Text(
              receiptText,
              style: const TextStyle(fontFamily: 'Courier', fontSize: 16),
            ),
            const Spacer(),

            // QR Code
            const Center(
              child: Text(
                "Scan untuk validasi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: QrImageView(
                data: receiptText, // data di-encode dalam QR
                version: QrVersions.auto,
                size: 200,
              ),
            ),
            const SizedBox(height: 24),
            // Tombol kembali
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/dashboard',
                  (_) => false,
                ),
                child: const Text("Kembali ke Dashboard"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
