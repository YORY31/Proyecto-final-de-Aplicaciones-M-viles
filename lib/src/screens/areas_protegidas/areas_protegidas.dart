class AreaProtegida {
  final String id;
  final String nombre;
  final String tipo;
  final String descripcion;
  final String ubicacion;
  final String superficie;
  final String imagen;
  final double latitud;
  final double longitud;

  AreaProtegida({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.descripcion,
    required this.ubicacion,
    required this.superficie,
    required this.imagen,
    required this.latitud,
    required this.longitud,
  });

  factory AreaProtegida.fromJson(Map<String, dynamic> json) {
    return AreaProtegida(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      tipo: json['tipo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      ubicacion: json['ubicacion'] ?? '',
      superficie: json['superficie'] ?? '',
      imagen: json['imagen'] ?? '',
      latitud: (json['latitud'] ?? 0).toDouble(),
      longitud: (json['longitud'] ?? 0).toDouble(),
    );
  }
}
