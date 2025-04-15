// app_constants.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static Color primaryColor = const Color(0xFF1E88E5); // Blue
  static Color primaryVariant = const Color(0xFF1565C0); // Darker blue
  static Color accentColor = const Color(0xFFFF6D00); // Orange

  // UI colors
  static Color backgroundColor = const Color(0xFFF5F5F5);
  static Color appbargroundColor = primaryColor;
  static Color cardColor = Colors.white;
  static Color dividerColor = const Color(0xFFE0E0E0);

  // Text colors
  static Color textPrimary = const Color(0xFF212121);
  static Color textSecondary = const Color(0xFF757575);
  static Color textHint = const Color(0xFFBDBDBD);

  // Neutrals
  static Color neutralBlack = const Color(0xFF212121);
  static Color neutralDarkGrey = const Color(0xFF616161);
  static Color neutralGrey = const Color(0xFF9E9E9E);
  static Color neutralLightGrey = const Color(0xFFEEEEEE);

  // Status colors
  static Color successColor = const Color(0xFF4CAF50);
  static Color warningColor = const Color(0xFFFFC107);
  static Color errorColor = const Color(0xFFF44336);
  static Color infoColor = const Color(0xFF2196F3);

  // Shimmer colors
  static Color shimmerBaseColor = const Color(0xFFE0E0E0);
  static Color shimmerHighlightColor = const Color(0xFFF5F5F5);
}

class AppTextStyles {
  static const String fontFamily = 'Poppins';

  // Display styles
  static TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Title styles
  static TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body styles
  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Label styles
  static TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Button styles
  static TextStyle buttonLarge = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle buttonMedium = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle buttonSmall = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
