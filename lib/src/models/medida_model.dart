// Modelo de datos para una medida ambiental.
class MedidaModel {
  // Identificador único de la medida.
  final String id;
  // Título o nombre de la medida.
  final String titulo;
  // Descripción breve de la medida.
  final String? descripcion;
  // Contenido detallado de la medida.
  final String? contenido;
  // URL de la imagen asociada a la medida.
  final String? imagen;

  // Constructor del modelo.
  MedidaModel({
    required this.id,
    required this.titulo,
    this.descripcion,
    this.contenido,
    this.imagen,
  });

  // Método para crear una instancia desde un Map (JSON).
  factory MedidaModel.fromJson(Map<String, dynamic> json) {
    // Función auxiliar para obtener el primer valor válido de varias claves.
    String pickS(List<String> keys) => keys
        .map((k) => json[k])
        .firstWhere(
          (v) => v != null && v.toString().isNotEmpty,
          orElse: () => '',
        )
        .toString();

    return MedidaModel(
      id: pickS(['id', 'ID']), // Busca el id en varias posibles claves.
      titulo: pickS([
        'titulo',
        'title',
        'nombre',
      ]), // Busca el título en varias claves.
      descripcion: (json['descripcion'] ?? json['resumen'])?.toString(),
      contenido: (json['contenido'] ?? json['detalle'] ?? json['content'])
          ?.toString(),
      imagen: (json['imagen'] ?? json['image'])?.toString(),
    );
  }
}
