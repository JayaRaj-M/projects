import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TextStyles {
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
    titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
    titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
  );

  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textLight),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textLight),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textLight),
    headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textLight),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textLight),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textLight),
    titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textLight),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textLight),
    titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textLight),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textLight),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryLight),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
  );
}