import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF4ECDC4); // Mint Green
  static const Color secondary = Color(0xFF556270); // Deep Gray Blue
  static const Color background = Color(0xFFF7FFF7); // Off White
  static const Color accent = Color(0xFFFF6B6B); // Coral Red

  // Text Colors
  static const Color textPrimary = Color(0xFF2E2E2E);
  static const Color textSecondary = Color(0xFF6C757D);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF2D2D2D);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  // Weather Colors
  static const Color sunny = Color(0xFFFFA726);
  static const Color cloudy = Color(0xFF78909C);
  static const Color rainy = Color(0xFF42A5F5);
  static const Color snowy = Color(0xFFE0E0E0);
  static const Color thunderstorm = Color(0xFF5E35B1);
  static const Color mist = Color(0xFF90A4AE);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF42A5F5);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunnyGradient = LinearGradient(
    colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cloudyGradient = LinearGradient(
    colors: [Color(0xFF78909C), Color(0xFF546E7A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient rainyGradient = LinearGradient(
    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient thunderstormGradient = LinearGradient(
    colors: [Color(0xFF5E35B1), Color(0xFF4527A0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient mistGradient = LinearGradient(
    colors: [Color(0xFF90A4AE), Color(0xFF78909C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

