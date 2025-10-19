import 'package:flutter/material.dart';

const primaryColor = Color(0xFF1173d4);
const backgroundLightColor = Color(0xFFf6f7f8);
const textDarkColor = Color(0xFF101922);
const textGreyColor = Color(0xFF6B7280);
const textHeaderColor = Color(0xFF374151);
const borderColor = Color(0xFFE5E7EB); // border-gray-200 / border-gray-300
const cardBackgroundColor = Colors.white;
const tableHeaderColor = Color(0xFFF9FAFB); // bg-gray-50
const hoverColor = Color(0xFFF9FAFB);

const statusInStockText = Color(0xFF027A48);
const statusInStockBg = Color(0xFFD1FADF);
const statusOutOfStockText = Color(0xFFB42318);
const statusOutOfStockBg = Color(0xFFFEF3F2);


ThemeData buildAppTheme() {
  return ThemeData(
    fontFamily: 'Inter',
    useMaterial3: true,
    
    scaffoldBackgroundColor: backgroundLightColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      surface: backgroundLightColor,
    ),

    textTheme: const TextTheme(
      headlineMedium: TextStyle(color: textDarkColor, fontWeight: FontWeight.w700, fontSize: 30),
      titleLarge: TextStyle(color: textDarkColor, fontWeight: FontWeight.w700, fontSize: 20),
      bodyMedium: TextStyle(color: textHeaderColor, fontWeight: FontWeight.w500, fontSize: 14),
      bodySmall: TextStyle(color: textDarkColor, fontWeight: FontWeight.w400, fontSize: 12),
    ),

    cardTheme: const CardThemeData(
      color: cardBackgroundColor,
      surfaceTintColor: cardBackgroundColor,
      elevation: 2.0,
      shadowColor: Color(0x1A101922),
      margin: EdgeInsets.zero,
    ),
    dividerTheme: DividerThemeData(color: borderColor, space: 1, thickness: 1),
    
    inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: cardBackgroundColor,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
  );
}