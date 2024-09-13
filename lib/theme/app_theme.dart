import 'package:chatbot/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
    ),
    hintColor: AppColors.hintColor,
    disabledColor: AppColors.disabledColor,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppSizes.fontSizeLarge,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    // textTheme: const TextTheme(
    //   displayLarge: TextStyle(
    //     color: AppColors.textPrimary,
    //     fontSize: 32,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   headlineMedium: TextStyle(
    //     color: AppColors.textPrimary,
    //     fontSize: AppSizes.fontSizeLarge,
    //   ),
    //   bodyLarge: TextStyle(
    //     color: AppColors.textSecondary,
    //     fontSize: 16,
    //   ),
    //   bodyMedium: TextStyle(
    //     color: AppColors.textPrimary,
    //     fontSize: 14,
    //   ),
    // ),
    switchTheme: SwitchThemeData(
      thumbIcon: WidgetStateProperty.all(const Icon(Icons.nightlight)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColorsDark.textPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.disabledColor; // Disabled color
            }
            return AppColors.primary; // Regular color
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.black26; // Disabled text color
            }
            return Colors.white; // Regular text color
          },
        ),
        overlayColor: WidgetStateProperty.all(
          AppColors.secondary.withOpacity(0.2),
        ), // Ripple color
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
        ),
        elevation: WidgetStateProperty.all(1.0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.inputBorderColor, width: 1),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.inputBorderColor, width: 1),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.disabledColor, width: .5),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.paddingMedium,
        horizontal: AppSizes.paddingLarge,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColorsDark.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      secondary: AppColorsDark.secondary,
      surface: AppColorsDark.background,
      onSurface: AppColorsDark.textPrimary,
    ),
    hintColor: AppColorsDark.hintColor,
    disabledColor: AppColorsDark.disabledColor,
    scaffoldBackgroundColor: AppColorsDark.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsDark.background,
      titleTextStyle: TextStyle(
        color: AppColorsDark.textPrimary,
        fontSize: AppSizes.fontSizeLarge,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColorsDark.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorsDark.background,
    ),
    // textTheme: const TextTheme(
    //   displayLarge: TextStyle(
    //     color: AppColorsDark.textPrimary,
    //     fontSize: 32,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   headlineMedium: TextStyle(
    //     color: AppColorsDark.textPrimary,
    //     fontSize: AppSizes.fontSizeLarge,
    //   ),
    //   bodyLarge: TextStyle(
    //     color: AppColorsDark.textPrimary,
    //     fontSize: 16,
    //   ),
    //   bodyMedium: TextStyle(
    //     color: AppColorsDark.textPrimary,
    //     fontSize: 14,
    //   ),
    // ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColorsDark.accent),
      trackColor: WidgetStateProperty.all(AppColors.primary),
      thumbIcon: WidgetStateProperty.all(const Icon(Icons.sunny)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey[700]; // Disabled color
            }
            return AppColors.primary; // Regular color
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey[500]; // Disabled text color
            }
            return Colors.white; // Regular text color
          },
        ),
        overlayColor: WidgetStateProperty.all(
          AppColors.secondary.withOpacity(0.1),
        ), // Ripple color
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColorsDark.primary),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorsDark.hintColor),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorsDark.hintColor),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.paddingMedium,
        horizontal: AppSizes.paddingLarge,
      ),
    ),
  );
}