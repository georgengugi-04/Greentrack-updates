import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const night = Color(0xFF080C0A);
  static const charcoal = Color(0xFF111813);
  static const panel = Color(0xFF18231B);
  static const glow = Color(0xFFB778FF);
  static const soil = Color(0xFF1A2E1A);
  static const canopy = Color(0xFF2D5A27);
  static const leaf = Color(0xFF4A8C3F);
  static const sprout = Color(0xFF7DBF6E);
  static const harvest = Color(0xFFD4880A);
  static const clay = Color(0xFFF2EDE8);
  static const bark = Color(0xFF5C4B3A);
  static const mist = Color(0xFFEDF2EC);
  static const alert = Color(0xFFB83232);
  static const safe = Color(0xFF2E7D32);
  static const warning = Color(0xFFE65100);
  static const border = Color(0xFFDDD8D0);
  static const cardBg = Color(0xFFFFFFFF);
  static const slate = Color(0xFF6B7280);
  static const slateLight = Color(0xFF9CA3AF);
  static const alertLight = Color(0xFFFFF3F3);
  static const forest = canopy;
  static const cream = Color(0xFFFFFBF4);
  static const parchment = Color(0xFFF8F2E8);
  static const amber = Color(0xFFF0A500);
  static const amberPale = Color(0xFFFFF4D6);
  static const paleGreen = Color(0xFFEAF7E7);
  static const mint = Color(0xFFB6E6C2);
  static const blue = Color(0xFF2B6CB0);
  static const blueLight = Color(0xFFE8F1FF);
  static const purple = Color(0xFF7C4DFF);
  static const purpleLight = Color(0xFFF0E8FF);
  static const red = alert;
  static const redLight = alertLight;
  static const error = alert;
  static const errorLight = alertLight;
  static const success = safe;
  static const successLight = paleGreen;
  static const slateMid = Color(0xFF4B5563);
  static const borderLight = Color(0xFFF0ECE5);

  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2E1A), Color(0xFF2D5A27)],
  );
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF111813), Color(0xFF234A24), Color(0xFF7C4DFF)],
  );
  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D5A27), Color(0xFF4A8C3F)],
  );
  static const mintGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7DBF6E), Color(0xFFB6E6C2)],
  );
  static const harvestGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD4880A), Color(0xFFF0A500)],
  );
}

class AppTextStyles {
  static TextStyle serif(double size, {Color? color, FontWeight? weight}) =>
      GoogleFonts.dmSerifDisplay(
          fontSize: size,
          color: color ?? AppColors.soil,
          fontWeight: weight ?? FontWeight.w400);

  static TextStyle sans(double size,
          {Color? color, FontWeight? weight, double? height}) =>
      GoogleFonts.dmSans(
          fontSize: size,
          height: height,
          color: color ?? AppColors.bark,
          fontWeight: weight ?? FontWeight.w400);

  static TextStyle mono(double size, {Color? color, FontWeight? weight}) =>
      GoogleFonts.jetBrainsMono(
          fontSize: size,
          color: color ?? AppColors.soil,
          fontWeight: weight ?? FontWeight.w600);

  static TextStyle display(double size, {Color? color, FontWeight? weight}) =>
      GoogleFonts.dmSerifDisplay(
          fontSize: size,
          color: color ?? AppColors.soil,
          fontWeight: weight ?? FontWeight.w400);

  static TextStyle body(double size,
          {Color? color,
          FontWeight? weight,
          double? letterSpacing,
          double? height}) =>
      GoogleFonts.dmSans(
          fontSize: size,
          letterSpacing: letterSpacing,
          height: height,
          color: color ?? AppColors.bark,
          fontWeight: weight ?? FontWeight.w400);

  static TextStyle label(
          {double size = 12,
          Color? color,
          FontWeight? weight,
          double? letterSpacing}) =>
      GoogleFonts.dmSans(
          fontSize: size,
          letterSpacing: letterSpacing,
          color: color ?? AppColors.slate,
          fontWeight: weight ?? FontWeight.w700);
}

class AppShadows {
  static BoxShadow get subtle => BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 10,
        offset: const Offset(0, 4),
      );

  static BoxShadow get card => BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 18,
        offset: const Offset(0, 10),
      );

  static BoxShadow get large => BoxShadow(
        color: AppColors.canopy.withOpacity(0.22),
        blurRadius: 28,
        offset: const Offset(0, 14),
      );

  static BoxShadow get fab => BoxShadow(
        color: AppColors.glow.withOpacity(0.38),
        blurRadius: 18,
        spreadRadius: 1,
        offset: const Offset(0, 8),
      );
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.canopy,
            primary: AppColors.canopy,
            secondary: AppColors.harvest,
            surface: AppColors.clay),
        scaffoldBackgroundColor: AppColors.clay,
        cardTheme: CardThemeData(
            color: AppColors.cardBg,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.border))),
        appBarTheme: AppBarTheme(
            backgroundColor: AppColors.clay,
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: const IconThemeData(color: AppColors.soil),
            titleTextStyle: AppTextStyles.serif(18, color: AppColors.soil)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.canopy,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                textStyle: GoogleFonts.dmSans(
                    fontSize: 15, fontWeight: FontWeight.w600),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.canopy,
                side: const BorderSide(color: AppColors.canopy, width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                textStyle: GoogleFonts.dmSans(
                    fontSize: 15, fontWeight: FontWeight.w600),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24))),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: AppColors.leaf,
                textStyle: GoogleFonts.dmSans(
                    fontSize: 14, fontWeight: FontWeight.w600))),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle:
                GoogleFonts.dmSans(color: AppColors.slateLight, fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.leaf, width: 2)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
        textTheme: TextTheme(
            displayLarge: AppTextStyles.serif(32),
            displayMedium: AppTextStyles.serif(26),
            headlineLarge: AppTextStyles.serif(24),
            headlineMedium: AppTextStyles.serif(20),
            headlineSmall: AppTextStyles.serif(18),
            titleLarge: AppTextStyles.sans(18, weight: FontWeight.w700),
            titleMedium: AppTextStyles.sans(16, weight: FontWeight.w600),
            titleSmall: AppTextStyles.sans(14, weight: FontWeight.w600),
            bodyLarge: AppTextStyles.sans(16),
            bodyMedium: AppTextStyles.sans(14, color: AppColors.slate),
            bodySmall: AppTextStyles.sans(12, color: AppColors.slateLight),
            labelLarge: AppTextStyles.sans(14, weight: FontWeight.w600),
            labelMedium: AppTextStyles.sans(13,
                weight: FontWeight.w600, color: AppColors.bark),
            labelSmall: AppTextStyles.sans(11, color: AppColors.slateLight)),
        dividerTheme: const DividerThemeData(color: AppColors.border, space: 1),
      );
}
