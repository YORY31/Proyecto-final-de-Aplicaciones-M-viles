import 'package:flutter/material.dart';
import './src/screens/home/home_screen.dart';
import './src/screens/about/about_us.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SobreNosotrosScreen(),
    );
  }
}
