import 'package:flutter/material.dart';

/// App color tokens.
/// Replace these with values from Figma when you start styling screens.
abstract final class AppColors {
  static const Color primary = Color(0xFF4A6CF7);
  static const Color secondary = Color(0xFF6C757D);
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1D26);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color disabled = Color(0xFFD1D5DB);

  /// Category colors. Categories store an index into this list,
  /// so only append new colors (never reorder) to keep saved data valid.
  static const List<Color> categoryPalette = [
    Color(0xFF4A6CF7),
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFF06B6D4),
    Color(0xFFEC4899),
    Color(0xFF84CC16),
  ];

  static Color categoryColor(int index) =>
      categoryPalette[index % categoryPalette.length];
}
