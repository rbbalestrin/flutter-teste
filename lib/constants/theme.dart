import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Paleta de cores principal para o Alpha Learn
class AlphaColors {
  // Cores principais
  static const Color primary = Color(0xFF6979F8);
  static const Color secondary = Color(0xFFFF647C);
  static const Color tertiary = Color(0xFF00C48C);
  static const Color background = Color(0xFFF5F6FA);
  static const Color cardBackground = Colors.white;
  static const Color success = Color(0xFF00C48C);
  static const Color warning = Color(0xFFFFBE0B);
  static const Color error = Color(0xFFFF5C5C);
  static const Color info = Color(0xFF5BC0DE);
  static const Color textPrimary = Color(0xFF1E2742);
  static const Color textSecondary = Color(0xFF78839D);
  static const Color divider = Color(0xFFE8ECEF);
  static const Color shadow = Color(0x10000000);
  
  // Cores para elementos diferentes nas telas
  static const Color background = Color(0xFFF7F9FF);   // Fundo claro
  static const Color cardBackground = Color(0xFFFFFFFF); // Fundo de card
  static const Color textPrimary = Color(0xFF3A3A3A);  // Texto principal
  static const Color textSecondary = Color(0xFF6F6F6F); // Texto secundário
  
  // Cores para os personagens
  static const List<Color> characterColors = [
    Color(0xFF5BD6F9),  // Azul claro
    Color(0xFFFF8FA3),  // Rosa
    Color(0xFFA0E66E),  // Verde claro
    Color(0xFFFFD166),  // Amarelo
    Color(0xFFB78DFF),  // Lilás
  ];
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF8E9BFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, Color(0xFFFF9EB1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient tertiaryGradient = LinearGradient(
    colors: [tertiary, Color(0xFF5EEDBF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Tema para o app Alpha Learn
class AlphaTheme {
  // Tema claro para o aplicativo
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AlphaColors.primary,
      scaffoldBackgroundColor: AlphaColors.background,
      colorScheme: const ColorScheme.light(
        primary: AlphaColors.primary,
        secondary: AlphaColors.secondary,
        error: AlphaColors.error,
        background: AlphaColors.background,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AlphaColors.primary,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AlphaColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AlphaColors.primary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: AlphaColors.cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AlphaColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AlphaColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AlphaColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AlphaColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AlphaColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AlphaColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AlphaColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: a20,
          fontWeight: FontWeight.bold,
          color: AlphaColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AlphaColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AlphaColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AlphaColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AlphaColors.textSecondary,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AlphaColors.primary,
        unselectedItemColor: AlphaColors.textSecondary,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}

// Constantes de tamanho
const double a4 = 4.0;
const double a8 = 8.0;
const double a12 = 12.0;
const double a16 = 16.0;
const double a20 = 20.0;
const double a24 = 24.0;
const double a32 = 32.0;
const double a40 = 40.0;
const double a48 = 48.0;
const double a56 = 56.0;
const double a64 = 64.0;
const double a80 = 80.0; 