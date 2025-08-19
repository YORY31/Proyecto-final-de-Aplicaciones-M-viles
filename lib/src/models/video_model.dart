// Modelo de datos para un video educativo.
class VideoModel {
  // Identificador único del video.
  final String id;
  // Título del video.
  final String titulo;
  // Descripción breve del video.
  final String? descripcion;
  // URL del video (YouTube, mp4, etc.).
  final String? url;
  // URL de la imagen miniatura (thumbnail).
  final String? imagen;
  // Fecha de publicación del video.
  final DateTime? fecha;

  // Constructor del modelo.
  VideoModel({
    required this.id,
    required this.titulo,
    this.descripcion,
    this.url,
    this.imagen,
    this.fecha,
  });

  // Método para crear una instancia desde un Map (JSON).
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    // Función auxiliar para obtener el primer valor válido de varias claves.
    String pickS(List<String> keys) => keys
        .map((k) => json[k])
        .firstWhere(
          (v) => v != null && v.toString().isNotEmpty,
          orElse: () => '',
        )
        .toString();

    // Función auxiliar para obtener la fecha desde varias posibles claves.
    DateTime? pickDate(List<String> keys) {
      for (final k in keys) {
        final v = json[k];
        if (v is String && v.isNotEmpty) {
          try {
            return DateTime.parse(v);
          } catch (_) {}
        }
      }
      return null;
    }

    return VideoModel(
      id: pickS(['id', 'ID']), // Busca el id en varias posibles claves.
      titulo: pickS([
        'titulo',
        'title',
        'nombre',
      ]), // Busca el título en varias claves.
      descripcion:
          (json['descripcion'] ?? json['resumen'] ?? json['description'])
              ?.toString(),
      url: (json['url'] ?? json['link'] ?? json['video'])?.toString(),
      imagen: (json['imagen'] ?? json['thumbnail'])?.toString(),
      fecha: pickDate([
        'fecha',
        'created_at',
        'date',
      ]), // Busca la fecha en varias claves.
    );
  }
}
