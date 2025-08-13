// Importa el paquete principal de Flutter y los estilos definidos.
import 'package:flutter/material.dart';
import 'app_color.dart';
import './app_text_styles.dart';

// Clase que agrupa la configuración de temas globales de la app.
class AppTheme {
  // Tema claro principal de la aplicación.
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary, // Color principal.
    scaffoldBackgroundColor: AppColors.background, // Color de fondo.
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.heading1, // Estilo para títulos grandes.
      bodyLarge: AppTextStyles.body, // Estilo para textos de cuerpo.
    ),
  );
}
