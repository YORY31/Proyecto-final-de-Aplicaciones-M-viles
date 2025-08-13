// Importa librerías para manejo de HTTP y decodificación JSON.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyectofinalmovil/src/models/video_model.dart';
import 'package:proyectofinalmovil/src/models/medida_model.dart';

// Servicio para consumir la API de medio ambiente.
class ApiConsumerService {
  // Cliente HTTP reutilizable.
  ApiConsumerService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  // URL base de la API.
  static const String _base = 'https://adamix.net/medioambiente';

  // Método privado para obtener una lista desde la API.
  Future<List<dynamic>> _getList(String path) async {
    final res = await _client
        .get(Uri.parse('$_base/$path'), headers: {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 12));

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.reasonPhrase ?? 'Error'}');
    }

    // Decodifica el cuerpo de la respuesta.
    final body = utf8.decode(res.bodyBytes, allowMalformed: true);
    final decoded = jsonDecode(body);
    if (decoded is List) return decoded;
    if (decoded is Map && decoded['data'] is List)
      return List.from(decoded['data']);
    throw const FormatException('Respuesta inesperada del API');
  }

  // Obtiene la lista de videos desde la API y los convierte en modelos.
  Future<List<VideoModel>> getVideos() async => (await _getList('videos'))
      .map<VideoModel>((e) => VideoModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  // Obtiene la lista de medidas desde la API y los convierte en modelos.
  Future<List<MedidaModel>> getMedidas() async => (await _getList('medidas'))
      .map<MedidaModel>(
        (e) => MedidaModel.fromJson(Map<String, dynamic>.from(e)),
      )
      .toList();
}
