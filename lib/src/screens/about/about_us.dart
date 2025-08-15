import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/core/theme/app_color.dart';
import 'package:proyectofinalmovil/core/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreNosotrosScreen extends StatelessWidget {
  const SobreNosotrosScreen({super.key});

  final String youtubeUrl = "https://youtu.be/OvhDOwcmJ50";

  void _launchYoutube() async {
    final Uri url = Uri.parse(youtubeUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("No se pudo abrir el enlace: $youtubeUrl");
    }
  }

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
            ElevatedButton(
              onPressed: _launchYoutube,
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
