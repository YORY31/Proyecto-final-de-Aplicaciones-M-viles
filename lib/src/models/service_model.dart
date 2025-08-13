// Modelo de datos para un servicio ambiental.
class ServiceModel {
  // Identificador único del servicio.
  String? id;
  // Nombre del servicio.
  final String nombre;
  // Descripción del servicio.
  final String descripcion;
  // Icono representativo del servicio.
  final String icono;

  // Constructor del modelo.
  ServiceModel({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.icono,
  });

  // Método para crear una instancia desde un Map (JSON).
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      icono: json['icono'],
    );
  }
}
