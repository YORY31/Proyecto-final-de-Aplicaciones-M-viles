import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/src/models/video_model.dart';
import 'package:proyectofinalmovil/src/services/api_consumer_service.dart';
import 'package:proyectofinalmovil/src/screens/videos/video_player_screen.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final api = ApiConsumerService();
  late Future<List<VideoModel>> _future;

  @override
  void initState() { super.initState(); _future = api.getVideos(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videos educativos')),
      body: FutureBuilder<List<VideoModel>>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          final items = snap.data ?? [];
          if (items.isEmpty) return const Center(child: Text('No hay videos disponibles.'));

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final v = items[i];
              return ListTile(
                leading: (v.imagen ?? '').isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(v.imagen!, width: 72, height: 48, fit: BoxFit.cover),
                )
                    : const Icon(Icons.play_circle_fill, size: 32),
                title: Text(v.titulo),
                subtitle: (v.descripcion ?? '').isNotEmpty
                    ? Text(v.descripcion!, maxLines: 2, overflow: TextOverflow.ellipsis)
                    : null,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VideoPlayerScreen(video: v)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
