// Importa el paquete principal de Flutter para construir interfaces.
import 'package:flutter/material.dart';
// Importa la configuración de rutas de la aplicación.
import 'package:proyectofinalmovil/core/routes/app_page.dart';
// Importa la pantalla principal (Home).
import 'package:proyectofinalmovil/screens/home_screen.dart';

// Función principal que inicia la aplicación ejecutando el widget raíz.
void main() => runApp(const MedioAmbienteApp());

// Widget principal de la aplicación, define la configuración global.
class MedioAmbienteApp extends StatelessWidget {
  // Constructor constante, buena práctica para widgets sin estado.
  const MedioAmbienteApp({super.key});

  // Método build: construye el árbol de widgets de la app.
  @override
  Widget build(BuildContext context) {
    // Definición de un color verde oscuro personalizado para el tema.
    const darkGreen = Color(0xFF1B5E20); // Verde oscuro elegante
    // MaterialApp es el widget raíz que configura la aplicación.
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de modo debug.
      title: 'Mobile Green Kode', // Título de la aplicación.
      theme: ThemeData(
        // Define el esquema de colores usando el verde oscuro como base.
        colorScheme: ColorScheme.fromSeed(seedColor: darkGreen),
        useMaterial3: true, // Activa Material Design 3.
        appBarTheme: const AppBarTheme(
          backgroundColor: darkGreen, // Color de fondo del AppBar.
          foregroundColor: Colors.white, // Color de texto/iconos en el AppBar.
          centerTitle: true, // Centra el título en el AppBar.
          elevation: 0, // Sin sombra en el AppBar.
        ),
      ),
      home: const HomeScreen(), // Pantalla principal de la app.
      routes: appPages, // Rutas de navegación definidas en la app.
    );
  }
}
