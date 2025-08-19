import 'package:flutter/material.dart';
import './core/theme/app_theme.dart';
import './core/routes/app_routes.dart';
import './src/screens/home/home_screen.dart';
import './src/screens/about/about_us.dart';
import './src/screens/auth/screens/login_screen.dart';
import './src/screens/auth/screens/menu_screen.dart';
import './src/screens/auth/screens/forget_password.dart';
import './src/screens/auth/screens/change_password_screen.dart';
import './src/screens/news/news_screen.dart';
import './src/screens/services/services_screens.dart';
import './src/screens/areas_protegidas/areas_protegidas_screen.dart';
import './src/screens/reports/create_report_screen.dart';
import './src/screens/reports/my_reports_screen.dart';
import './src/screens/reports/reports_map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.about: (context) => const SobreNosotrosScreen(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.menu: (context) => MenuScreen(),
        AppRoutes.forgotPassword: (context) => ForgotPasswordScreen(),
        AppRoutes.changePassword: (context) => ChangePasswordScreen(),
        AppRoutes.news: (context) => const NewsScreen(),
        AppRoutes.services: (context) => const ServicesScreens(),
        AppRoutes.areasProtegidas: (context) => AreasProtegidasScreen(),
        AppRoutes.createReport: (context) => const CreateReportScreen(),
        AppRoutes.myReports: (context) => const MyReportsScreen(),
        AppRoutes.reportsMap: (context) => const ReportsMapScreen(),
      },
    );
  }
}
