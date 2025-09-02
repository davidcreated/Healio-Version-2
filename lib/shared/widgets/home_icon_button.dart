// SEPARATE FILE: lib/src/widgets/home_icon_button.dart
// ==============================================================================
import 'package:flutter/material.dart';

/// Reusable icon button widget for home screen options
class HomeIconButton extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback? onTap;

  const HomeIconButton({
    super.key,
    required this.image,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8FEFA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                image,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'NotoSans',
                color: Color(0xFF094067),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
