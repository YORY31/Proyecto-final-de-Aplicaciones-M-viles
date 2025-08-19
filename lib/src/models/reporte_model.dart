class Reporte {
  final String id;
  final String codigo;
  final String titulo;
  final String descripcion;
  final String foto;
  final double latitud;
  final double longitud;
  final String estado;
  final String? comentarioMinisterio;
  final DateTime fecha;

  Reporte({
    required this.id,
    required this.codigo,
    required this.titulo,
    required this.descripcion,
    required this.foto,
    required this.latitud,
    required this.longitud,
    required this.estado,
    this.comentarioMinisterio,
    required this.fecha,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      id: json['id'] ?? '',
      codigo: json['codigo'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      foto: json['foto'] ?? '',
      latitud: (json['latitud'] ?? 0).toDouble(),
      longitud: (json['longitud'] ?? 0).toDouble(),
      estado: json['estado'] ?? '',
      comentarioMinisterio: json['comentario_ministerio'],
      fecha: DateTime.parse(json['fecha'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'foto': foto,
      'latitud': latitud,
      'longitud': longitud,
    };
  }
}

class CreateReportRequest {
  final String titulo;
  final String descripcion;
  final String foto;
  final double latitud;
  final double longitud;

  CreateReportRequest({
    required this.titulo,
    required this.descripcion,
    required this.foto,
    required this.latitud,
    required this.longitud,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'foto': foto,
      'latitud': latitud.toString(),
      'longitud': longitud.toString(),
    };
  }
}
