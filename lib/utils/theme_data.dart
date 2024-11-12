import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_palette.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: ColorPalette.primaryLight,
  colorScheme: const ColorScheme.light(
    primary: ColorPalette.primaryLight,
    secondary: ColorPalette.secondaryLight,
    surface: ColorPalette.surfaceLight,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: ColorPalette.textLight,
  ),
  scaffoldBackgroundColor: ColorPalette.backgroundLight,
  cardColor: ColorPalette.surfaceLight,
  fontFamily: GoogleFonts.roboto().fontFamily,
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    bodyLarge: GoogleFonts.roboto(color: ColorPalette.textLight),
    bodyMedium: GoogleFonts.roboto(color: ColorPalette.textLight),
    titleLarge: GoogleFonts.roboto(
      color: ColorPalette.textLight,
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorPalette.primaryLight,
    foregroundColor: Colors.white,
    elevation: 4,
    shadowColor: Colors.black26,
    centerTitle: true,
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  ),
  iconTheme: const IconThemeData(color: ColorPalette.primaryLight),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorPalette.accentLight,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(ColorPalette.primaryLight),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      elevation: const WidgetStatePropertyAll(2),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: ColorPalette.primaryDark,
  colorScheme: const ColorScheme.dark(
    primary: ColorPalette.primaryDark,
    secondary: ColorPalette.secondaryDark,
    surface: ColorPalette.surfaceDark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: ColorPalette.textDark,
  ),
  scaffoldBackgroundColor: ColorPalette.backgroundDark,
  cardColor: ColorPalette.surfaceDark,
  fontFamily: GoogleFonts.roboto().fontFamily,
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    bodyLarge: GoogleFonts.roboto(color: ColorPalette.textDark),
    bodyMedium: GoogleFonts.roboto(color: ColorPalette.textDark),
    titleLarge: GoogleFonts.roboto(
      color: ColorPalette.textDark,
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorPalette.primaryDark,
    foregroundColor: Colors.white,
    elevation: 4,
    shadowColor: Colors.black45,
    centerTitle: true,
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  ),
  iconTheme: const IconThemeData(color: ColorPalette.primaryDark),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorPalette.accentDark,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(ColorPalette.primaryDark),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      elevation: const WidgetStatePropertyAll(2),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
);
