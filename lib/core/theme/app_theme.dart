import 'package:flutter/material.dart';
import '../../gen/fonts.gen.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.inter,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary500,
        primary: AppColors.primary500,
        secondary: AppColors.secondary500,
        surface: AppColors.gray50,
        error: AppColors.accentRed,
        onPrimary: AppColors.basicWhite,
        onSecondary: AppColors.basicWhite,
        onSurface: AppColors.gray900,
        onError: AppColors.basicWhite,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyle.h1Bold,
        displayMedium: AppTextStyle.h2Bold,
        displaySmall: AppTextStyle.h3Bold,
        headlineLarge: AppTextStyle.h4Bold,
        headlineMedium: AppTextStyle.h5Bold,
        headlineSmall: AppTextStyle.lgBold,
        titleLarge: AppTextStyle.baseBold,
        titleMedium: AppTextStyle.smBold,
        titleSmall: AppTextStyle.xsBold,
        bodyLarge: AppTextStyle.baseRegular,
        bodyMedium: AppTextStyle.smRegular,
        bodySmall: AppTextStyle.xsRegular,
        labelLarge: AppTextStyle.baseMedium,
        labelMedium: AppTextStyle.smMedium,
        labelSmall: AppTextStyle.xsMedium,
      ),
      scaffoldBackgroundColor: AppColors.basicWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.basicWhite,
        foregroundColor: AppColors.gray900,
        elevation: 0,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.inter,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.primary500,
        primary: AppColors.primary300,
        secondary: AppColors.secondary300,
        surface: AppColors.gray900,
        error: AppColors.accentRed,
        onPrimary: AppColors.gray900,
        onSecondary: AppColors.gray900,
        onSurface: AppColors.basicWhite,
        onError: AppColors.basicWhite,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyle.h1Bold.copyWith(color: AppColors.basicWhite),
        displayMedium: AppTextStyle.h2Bold.copyWith(color: AppColors.basicWhite),
        displaySmall: AppTextStyle.h3Bold.copyWith(color: AppColors.basicWhite),
        headlineLarge: AppTextStyle.h4Bold.copyWith(color: AppColors.basicWhite),
        headlineMedium: AppTextStyle.h5Bold.copyWith(color: AppColors.basicWhite),
        headlineSmall: AppTextStyle.lgBold.copyWith(color: AppColors.basicWhite),
        titleLarge: AppTextStyle.baseBold.copyWith(color: AppColors.basicWhite),
        titleMedium: AppTextStyle.smBold.copyWith(color: AppColors.basicWhite),
        titleSmall: AppTextStyle.xsBold.copyWith(color: AppColors.basicWhite),
        bodyLarge: AppTextStyle.baseRegular.copyWith(color: AppColors.gray100),
        bodyMedium: AppTextStyle.smRegular.copyWith(color: AppColors.gray100),
        bodySmall: AppTextStyle.xsRegular.copyWith(color: AppColors.gray100),
        labelLarge: AppTextStyle.baseMedium.copyWith(color: AppColors.gray100),
        labelMedium: AppTextStyle.smMedium.copyWith(color: AppColors.gray100),
        labelSmall: AppTextStyle.xsMedium.copyWith(color: AppColors.gray100),
      ),
      scaffoldBackgroundColor: AppColors.gray900,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.gray900,
        foregroundColor: AppColors.basicWhite,
        elevation: 0,
      ),
    );
  }
}
