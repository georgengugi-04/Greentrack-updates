import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary Palette
  static const Color forest       = Color(0xFF1B4332);
  static const Color forestDark   = Color(0xFF0D2B1F);
  static const Color leaf         = Color(0xFF40916C);
  static const Color leafLight    = Color(0xFF52B788);
  static const Color mint         = Color(0xFF95D5B2);
  static const Color sage         = Color(0xFFB7E4C7);
  static const Color paleGreen    = Color(0xFFD8F3DC);

  // Neutrals
  static const Color parchment    = Color(0xFFF8F4EE);
  static const Color cream        = Color(0xFFFFFDF9);
  static const Color warmWhite    = Color(0xFFFFFFFF);
  static const Color slate        = Color(0xFF2D3748);
  static const Color slateMid     = Color(0xFF4A5568);
  static const Color slateLight   = Color(0xFF718096);
  static const Color border       = Color(0xFFE2E8DC);
  static const Color borderLight  = Color(0xFFF0F0EC);

  // Accents
  static const Color amber        = Color(0xFFD4A017);
  static const Color amberLight   = Color(0xFFF6D860);
  static const Color amberPale    = Color(0xFFFFF3CD);
  static const Color red          = Color(0xFFC0392B);
  static const Color redLight     = Color(0xFFFADBD8);
  static const Color blue         = Color(0xFF2B6CB0);
  static const Color blueLight    = Color(0xFFEBF4FF);
  static const Color purple       = Color(0xFF6B46C1);
  static const Color purpleLight  = Color(0xFFF3E8FF);

  // Status
  static const Color success      = Color(0xFF27AE60);
  static const Color successLight = Color(0xFFD5F5E3);
  static const Color warning      = Color(0xFFE67E22);
  static const Color warningLight = Color(0xFFFEF9E7);
  static const Color error        = Color(0xFFE74C3C);
  static const Color errorLight   = Color(0xFFFDECEA);
  static const Color info         = Color(0xFF2980B9);
  static const Color infoLight    = Color(0xFFD6EAF8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [forest, leaf],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [forestDark, forest, leaf],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient mintGradient = LinearGradient(
    colors: [leaf, mint],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunriseGradient = LinearGradient(
    colors: [Color(0xFF1B4332), Color(0xFF40916C), Color(0xFF95D5B2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.forest,
        brightness: Brightness.light,
        primary: AppColors.forest,
        secondary: AppColors.leaf,
        tertiary: AppColors.amber,
        surface: AppColors.cream,
        background: AppColors.parchment,
        error: AppColors.red,
      ),
      scaffoldBackgroundColor: AppColors.parchment,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: AppColors.border,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: AppColors.forest,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: AppColors.forest, size: 22),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      textTheme: _buildTextTheme(),
      cardTheme: CardTheme(
        color: AppColors.cream,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forest,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.forest,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.forest,
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cream,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.leaf, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        hintStyle: GoogleFonts.inter(color: AppColors.slateLight, fontSize: 14),
        labelStyle: GoogleFonts.inter(color: AppColors.slateMid, fontSize: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.paleGreen,
        labelStyle: GoogleFonts.inter(
          color: AppColors.forest,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cream,
        selectedItemColor: AppColors.forest,
        unselectedItemColor: AppColors.slateLight,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.forest,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.forest,
        contentTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.cream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: AppColors.forest,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.leaf,
        linearTrackColor: AppColors.border,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.selected) ? AppColors.leaf : Colors.white),
        trackColor: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.selected) ? AppColors.mint : AppColors.border),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.leaf,
        thumbColor: AppColors.forest,
        overlayColor: AppColors.leaf.withOpacity(0.1),
        inactiveTrackColor: AppColors.border,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.forest,
        unselectedLabelColor: AppColors.slateLight,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.leaf, width: 2.5),
        ),
        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
        unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.forest,
        brightness: Brightness.dark,
        primary: AppColors.mint,
        secondary: AppColors.leaf,
        surface: const Color(0xFF1A2520),
        background: const Color(0xFF0F1A14),
        error: AppColors.red,
      ),
      scaffoldBackgroundColor: const Color(0xFF0F1A14),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1A2520),
        elevation: 0,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: AppColors.sage,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: _buildDarkTextTheme(),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 48, fontWeight: FontWeight.w700,
        color: AppColors.forest, letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 36, fontWeight: FontWeight.w700,
        color: AppColors.forest, letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 28, fontWeight: FontWeight.w600,
        color: AppColors.forest,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 24, fontWeight: FontWeight.w700,
        color: AppColors.forest,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 20, fontWeight: FontWeight.w600,
        color: AppColors.forest,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 18, fontWeight: FontWeight.w600,
        color: AppColors.slate,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w700,
        color: AppColors.forest,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w600,
        color: AppColors.slate,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w600,
        color: AppColors.slateMid,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w400,
        color: AppColors.slate,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400,
        color: AppColors.slateMid,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w400,
        color: AppColors.slateLight,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 13, fontWeight: FontWeight.w600,
        color: AppColors.forest,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 11, fontWeight: FontWeight.w600,
        color: AppColors.slateMid,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10, fontWeight: FontWeight.w600,
        color: AppColors.slateLight,
        letterSpacing: 0.8,
      ),
    );
  }

  static TextTheme _buildDarkTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 48, fontWeight: FontWeight.w700,
        color: AppColors.sage, letterSpacing: -1.5,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 24, fontWeight: FontWeight.w700,
        color: AppColors.sage,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w700,
        color: AppColors.sage,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w400,
        color: AppColors.mint,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400,
        color: AppColors.mint.withOpacity(0.7),
      ),
    );
  }
}

// Text style helpers
class AppTextStyles {
  static TextStyle mono({
    double size = 14,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.slate,
  }) => GoogleFonts.jetBrainsMono(
    fontSize: size, fontWeight: weight, color: color,
  );

  static TextStyle display(double size, {Color color = AppColors.forest}) =>
    GoogleFonts.playfairDisplay(
      fontSize: size, fontWeight: FontWeight.w700,
      color: color, letterSpacing: -0.5,
    );

  static TextStyle body(double size, {
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.slate,
    double? letterSpacing,
  }) => GoogleFonts.inter(
    fontSize: size, fontWeight: weight,
    color: color, letterSpacing: letterSpacing,
  );

  static TextStyle label({
    double size = 11,
    Color color = AppColors.slateLight,
    double letterSpacing = 0.8,
  }) => GoogleFonts.inter(
    fontSize: size, fontWeight: FontWeight.w600,
    color: color, letterSpacing: letterSpacing,
    textBaseline: TextBaseline.alphabetic,
  );
}

// Spacing constants
class AppSpacing {
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double xxl = 48;

  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  static const EdgeInsets tilePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
}

// Radius constants
class AppRadius {
  static const double xs  = 6;
  static const double sm  = 8;
  static const double md  = 12;
  static const double lg  = 16;
  static const double xl  = 20;
  static const double xxl = 28;
  static const double full = 100;

  static BorderRadius card       = BorderRadius.circular(lg);
  static BorderRadius chip       = BorderRadius.circular(full);
  static BorderRadius button     = BorderRadius.circular(md);
  static BorderRadius input      = BorderRadius.circular(md);
  static BorderRadius bottomSheet = const BorderRadius.vertical(top: Radius.circular(xxl));
}

// Shadow constants
class AppShadows {
  static BoxShadow card = BoxShadow(
    color: AppColors.forest.withOpacity(0.06),
    blurRadius: 12,
    offset: const Offset(0, 4),
  );

  static BoxShadow large = BoxShadow(
    color: AppColors.forest.withOpacity(0.12),
    blurRadius: 24,
    offset: const Offset(0, 8),
  );

  static BoxShadow subtle = BoxShadow(
    color: AppColors.slate.withOpacity(0.04),
    blurRadius: 6,
    offset: const Offset(0, 2),
  );

  static BoxShadow fab = BoxShadow(
    color: AppColors.forest.withOpacity(0.3),
    blurRadius: 16,
    offset: const Offset(0, 6),
  );
}
