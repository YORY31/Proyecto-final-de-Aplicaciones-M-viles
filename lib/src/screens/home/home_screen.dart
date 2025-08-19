import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:proyectofinalmovil/core/theme/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> imgList = const [
    "https://picsum.photos/id/18/800/1600",
    "https://picsum.photos/id/19/800/1600",
    "https://picsum.photos/id/109/800/1600",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con slider a pantalla completa
          Positioned.fill(
            child: cs.CarouselSlider(
              options: cs.CarouselOptions(
                height: double.infinity,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
              ),
              items: imgList.map((url) {
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
            ),
          ),

          // Capa oscura para legibilidad
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(
                red: 0.0,
                green: 0.0,
                blue: 0.0,
                alpha: 0.4,
              ),
            ),
          ),

          // Texto central
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Bienvenido a AmbientflowRD",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background, // desde tu tema
                ),
              ),
            ),
          ),

          // Botón inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción al presionar
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, // color de tu tema
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
