// Importa el paquete principal de Flutter y los colores definidos.
import 'package:flutter/material.dart';
import 'app_color.dart';

// Clase que agrupa los estilos de texto reutilizables en la app.
class AppTextStyles {
  // Estilo para títulos grandes y destacados.
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Estilo para textos de cuerpo o contenido general.
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
}
