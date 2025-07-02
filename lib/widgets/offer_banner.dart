import 'package:flutter/material.dart';
import '../core/constants.dart';

class OfferBanner extends StatelessWidget {
  final String text;

  const OfferBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/coffee_bg.jpg',
          ), // atau hapus jika tidak ingin pakai background image
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
