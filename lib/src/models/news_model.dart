





class NewsModel {
  String? id;
  final String titulo;
  final String resumen;
  final String contenido;
  final String imagen;
  final DateTime fecha;

  NewsModel({
    this.id,
    required this.titulo,
    required this.resumen,
    required this.contenido,
    required this.imagen,
    required this.fecha
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      titulo: json['titulo'],
      resumen: json['resumen'],
      contenido: json['contenido'],
      imagen: json['imagen'],
      fecha: DateTime.parse(json['fecha'])
    );
  }
}