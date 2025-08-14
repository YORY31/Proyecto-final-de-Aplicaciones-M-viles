import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/core/theme/app_color.dart';
import 'package:proyectofinalmovil/core/theme/app_text_styles.dart';

class SobreNosotrosScreen extends StatelessWidget {
  const SobreNosotrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre Nosotros"),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nuestra Historia", style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              "Somos un ministerio comprometido con la proteccion del medio ambiente de nuestra amada Quisqueya!!💚...",
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 20),
            Text("Mision", style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              "Garantizar la conservación del medio ambiente y los recursos naturales de la República Dominicana, mediante la rectoría y regulación de la política medioambiental",
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 20),
            Text("Vision", style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              "Institución reconocida por su eficacia con la conservación del medio ambiente y los recursos naturales enfocado en el desarrollo sostenible del país, con una gestión funcionalmente integrada, eficiente y de calidad..",
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 20),
            Text("Video Institucional", style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://youtu.be/OvhDOwcmJ50?si=eB_wRNyd_2oEa1vx",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Ver Video",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
