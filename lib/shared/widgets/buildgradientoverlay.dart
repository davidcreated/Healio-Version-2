/// Gradient overlay for better text readability
import 'package:flutter/material.dart';
  Widget buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.1), // Light overlay at top
              Colors.black.withOpacity(0.3), // Darker overlay at bottom
            ],
            stops: const [0.0, 0.7],
          ),
        ),
      ),
    );
  }
