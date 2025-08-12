




class ServiceModel {
  String? id;
  final String nombre;
  final String descripcion;
  final String icono;

  ServiceModel({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.icono
  });


  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      nombre: json['nombre'], 
      descripcion: json['descripcion'], 
      icono: json['icono']
    );
  }
}