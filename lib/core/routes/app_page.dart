// Importa el paquete principal de Flutter para construir interfaces.
import 'package:flutter/material.dart';
// Importa las rutas definidas en la aplicación.
import 'package:proyectofinalmovil/core/routes/app_routes.dart';
// Importa la pantalla de videos educativos.
import 'package:proyectofinalmovil/src/screens/videos/videos_screen.dart';
// Importa la pantalla de medidas ambientales.
import 'package:proyectofinalmovil/src/screens/medidas/medidas_screen.dart';

// Mapa que asocia las rutas (strings) con los widgets correspondientes.
// Permite la navegación entre pantallas usando Navigator.pushNamed.
final Map<String, WidgetBuilder> appPages = {
  // Ruta para la pantalla de videos educativos.
  AppRoutes.videos: (_) => const VideosScreen(),
  // Ruta para la pantalla de medidas ambientales.
  AppRoutes.medidas: (_) => const MedidasScreen(),
};
