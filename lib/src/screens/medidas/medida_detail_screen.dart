import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/src/models/medida_model.dart';

class MedidaDetailScreen extends StatelessWidget {
  final MedidaModel medida;
  const MedidaDetailScreen({super.key, required this.medida});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(medida.titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((medida.imagen ?? '').isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(medida.imagen!, fit: BoxFit.cover),
              ),
            const SizedBox(height: 12),
            if ((medida.descripcion ?? '').isNotEmpty)
              Text(medida.descripcion!, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if ((medida.contenido ?? '').isNotEmpty)
              Text(medida.contenido!, textAlign: TextAlign.justify),
            if ((medida.descripcion ?? '').isEmpty && (medida.contenido ?? '').isEmpty)
              const Text('Sin contenido disponible.'),
          ],
        ),
      ),
    );
  }
}
