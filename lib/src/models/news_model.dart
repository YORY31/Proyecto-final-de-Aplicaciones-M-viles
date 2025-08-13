// Modelo de datos para una noticia ambiental.
class NewsModel {
  // Identificador único de la noticia.
  String? id;
  // Título de la noticia.
  final String titulo;
  // Resumen breve de la noticia.
  final String resumen;
  // Contenido completo de la noticia.
  final String contenido;
  // URL de la imagen asociada a la noticia.
  final String imagen;
  // Fecha de publicación de la noticia.
  final DateTime fecha;

  // Constructor del modelo.
  NewsModel({
    this.id,
    required this.titulo,
    required this.resumen,
    required this.contenido,
    required this.imagen,
    required this.fecha,
  });

  // Método para crear una instancia desde un Map (JSON).
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      titulo: json['titulo'],
      resumen: json['resumen'],
      contenido: json['contenido'],
      imagen: json['imagen'],
      fecha: DateTime.parse(
        json['fecha'],
      ), // Convierte la fecha de String a DateTime.
    );
  }
}
