import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/src/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel video;
  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? yt;
  WebViewController? web;

  @override
  void initState() {
    super.initState();
    final url = widget.video.url ?? '';
    final id = YoutubePlayer.convertUrlToId(url);

    if (id != null) {
      yt = YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    } else {
      web = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000));

      if (url.isNotEmpty) {
        web!.loadRequest(Uri.parse(url));
      } else {
        web!.loadHtmlString('<html><body><h3>No hay URL del video</h3></body></html>');
      }
    }
  }

  @override
  void dispose() { yt?.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.video.titulo)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: yt != null ? YoutubePlayer(controller: yt!) : WebViewWidget(controller: web!),
      ),
    );
  }
}
