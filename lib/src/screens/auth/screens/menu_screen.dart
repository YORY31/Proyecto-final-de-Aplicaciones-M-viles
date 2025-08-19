import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'change_password') {
                Navigator.pushNamed(context, '/change-password');
              } else if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'change_password',
                child: Row(
                  children: [
                    Icon(Icons.lock_reset),
                    SizedBox(width: 8),
                    Text('Cambiar Contraseña'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Cerrar Sesión'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.eco, size: 40, color: Colors.green),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AmbientFlow',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Medio Ambiente',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Opciones del Sistema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    icon: Icons.article,
                    title: 'Noticias',
                    subtitle: 'Ver noticias ambientales',
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/news'),
                  ),
                  _buildMenuCard(
                    icon: Icons.room_service,
                    title: 'Servicios',
                    subtitle: 'Servicios disponibles',
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/services'),
                  ),
                  _buildMenuCard(
                    icon: Icons.nature_people,
                    title: 'Áreas Protegidas',
                    subtitle: 'Explorar áreas protegidas',
                    color: Colors.teal,
                    onTap: () => Navigator.pushNamed(context, '/areas-protegidas'),
                  ),
                  _buildMenuCard(
                    icon: Icons.report_problem,
                    title: 'Crear Reporte',
                    subtitle: 'Reportar daño ambiental',
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/create-report'),
                  ),
                  _buildMenuCard(
                    icon: Icons.assignment,
                    title: 'Mis Reportes',
                    subtitle: 'Ver mis reportes',
                    color: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/my-reports'),
                  ),
                  _buildMenuCard(
                    icon: Icons.map,
                    title: 'Mapa Reportes',
                    subtitle: 'Ver reportes en mapa',
                    color: Colors.indigo,
                    onTap: () => Navigator.pushNamed(context, '/reports-map'),
                  ),
                  _buildMenuCard(
                    icon: Icons.settings,
                    title: 'Configuración',
                    subtitle: 'Ajustes del sistema',
                    color: Colors.grey,
                    onTap: () => Navigator.pushNamed(context, '/change-password'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar Sesión'),
          content: Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Cerrar Sesión'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }
}

//menu mas adelenate \

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       // home: SobreNosotrosScreen(),
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => LoginScreen(),
//         '/menu': (context) => MenuScreen(),
//         '/forgot-password': (context) => ForgotPasswordScreen(),
//         '/change-password': (context) => ChangePasswordScreen(),
//       },
//     );
//   }
// }
// }
