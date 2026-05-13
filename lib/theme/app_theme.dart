import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A9B8E);
  static const Color primaryDark = Color(0xFF2D7A6E);
  static const Color background = Color(0xFFF5F6FA);
  static const Color white = Colors.white;
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textMedium = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  static const Color cardBlue = Color(0xFFDBEAFF);
  static const Color cardTeal = Color(0xFFD0F0EC);
  static const Color cardGreen = Color(0xFFDCF5E4);
  static const Color cardYellow = Color(0xFFFFF3D0);
  static const Color cardPurple = Color(0xFFEDE9FE);
  static const Color cardPink = Color(0xFFFFE4E6);
  static const Color cardOrange = Color(0xFFFFEDD5);

  static const Color loanBlue = Color(0xFFBFD7FF);
  static const Color loanTeal = Color(0xFFB2E8E2);
  static const Color loanGreen = Color(0xFFC3EDD1);
  static const Color loanYellow = Color(0xFFFFE0A0);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textMedium,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textLight,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}