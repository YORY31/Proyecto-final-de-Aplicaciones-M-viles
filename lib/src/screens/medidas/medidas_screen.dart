import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/src/models/medida_model.dart';
import 'package:proyectofinalmovil/src/services/api_consumer_service.dart';
import 'package:proyectofinalmovil/src/screens/medidas/medida_detail_screen.dart';

class MedidasScreen extends StatefulWidget {
  const MedidasScreen({super.key});
  @override
  State<MedidasScreen> createState() => _MedidasScreenState();
}

class _MedidasScreenState extends State<MedidasScreen> {
  final api = ApiConsumerService();
  late Future<List<MedidaModel>> _future;

  @override
  void initState() { super.initState(); _future = api.getMedidas(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medidas ambientales')),
      body: FutureBuilder<List<MedidaModel>>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          final items = snap.data ?? [];
          if (items.isEmpty) return const Center(child: Text('No hay medidas disponibles.'));

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final m = items[i];
              return ListTile(
                leading: const Icon(Icons.eco_outlined),
                title: Text(m.titulo),
                subtitle: (m.descripcion ?? '').isNotEmpty
                    ? Text(m.descripcion!, maxLines: 2, overflow: TextOverflow.ellipsis)
                    : null,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MedidaDetailScreen(medida: m)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
