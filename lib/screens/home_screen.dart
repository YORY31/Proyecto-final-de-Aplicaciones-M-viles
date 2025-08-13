// Importa el paquete principal de Flutter y las rutas de la app.
import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/core/routes/app_routes.dart';

// Pantalla principal de la aplicación, muestra el menú de módulos.
class HomeScreen extends StatelessWidget {
  // Constructor constante.
  const HomeScreen({super.key});

  // Colores personalizados para el diseño.
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color softGreen = Color(0xFFE6F4EA);

  // Método para navegar a una ruta específica.
  void _go(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    // Cálculo responsive de columnas según el ancho de pantalla.
    final width = MediaQuery.of(context).size.width;
    final cross = width >= 720 ? 3 : 2;

    // Lista de módulos que se muestran en el menú principal.
    final items = <_HomeItem>[
      _HomeItem(
        title: 'Videos educativos',
        subtitle: 'Reciclaje, biodiversidad, clima…',
        icon: Icons.play_circle_fill_outlined,
        route: AppRoutes.videos,
      ),
      _HomeItem(
        title: 'Medidas ambientales',
        subtitle: 'Buenas prácticas y cuidado',
        icon: Icons.eco_outlined,
        route: AppRoutes.medidas,
      ),
      // Puedes agregar más módulos aquí…
    ];

    // Estructura visual de la pantalla principal.
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Green Kode')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [softGreen, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cross,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.02,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final it = items[index];
                    // Tarjeta visual para cada módulo del menú.
                    return _HomeCard(
                      icon: it.icon,
                      title: it.title,
                      subtitle: it.subtitle,
                      onTap: () => _go(context, it.route),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Barra inferior decorativa.
      bottomNavigationBar: Container(height: 18, color: darkGreen),
    );
  }
}

// Tarjeta visual para cada módulo del menú principal.
class _HomeCard extends StatelessWidget {
  const _HomeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  static const Color darkGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 4),
              color: Color(0x1A000000),
            ),
          ],
          border: Border.all(color: darkGreen.withValues(alpha: 0.25)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          // Distribuye el contenido para evitar overflow.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 42, color: darkGreen),
            // Título del módulo.
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                height: 1.2,
                color: darkGreen,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Subtítulo del módulo.
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
                height: 1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Espaciador para mejorar el diseño en pantallas pequeñas.
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}

// Modelo para cada módulo del menú principal.
class _HomeItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  _HomeItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}
