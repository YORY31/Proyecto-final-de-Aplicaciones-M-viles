import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import '../../models/reporte_model.dart';
import '../../services/reportes_service.dart';

class ReportsMapScreen extends StatefulWidget {
  const ReportsMapScreen({super.key});

  @override
  State<ReportsMapScreen> createState() => _ReportsMapScreenState();
}

class _ReportsMapScreenState extends State<ReportsMapScreen> {
  GoogleMapController? _mapController;
  List<Reporte> reportes = [];
  Set<Marker> markers = {};
  bool isLoading = true;
  String? error;

  // Ubicación por defecto (República Dominicana)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(18.4861, -69.9312), // Santo Domingo, República Dominicana
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    _loadReportes();
  }

  Future<void> _loadReportes() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final loadedReportes = await ReportesService.getReportes();
      setState(() {
        reportes = loadedReportes;
        isLoading = false;
      });
      _createMarkers();
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _createMarkers() {
    markers.clear();

    for (int i = 0; i < reportes.length; i++) {
      final reporte = reportes[i];

      markers.add(
        Marker(
          markerId: MarkerId(reporte.id),
          position: LatLng(reporte.latitud, reporte.longitud),
          icon: _getMarkerIcon(reporte.estado),
          infoWindow: InfoWindow(
            title: reporte.titulo,
            snippet: '${reporte.estado} - ${_formatDate(reporte.fecha)}',
            onTap: () => _showReporteDetails(reporte),
          ),
        ),
      );
    }

    setState(() {});

    // Ajustar la cámara para mostrar todos los marcadores
    if (reportes.isNotEmpty && _mapController != null) {
      _fitMarkersOnMap();
    }
  }

  BitmapDescriptor _getMarkerIcon(String estado) {
    switch (estado.toLowerCase()) {
      case 'pendiente':
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        );
      case 'en_proceso':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'resuelto':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'rechazado':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void _fitMarkersOnMap() {
    if (reportes.isEmpty) return;

    double minLat = reportes.first.latitud;
    double maxLat = reportes.first.latitud;
    double minLng = reportes.first.longitud;
    double maxLng = reportes.first.longitud;

    for (final reporte in reportes) {
      minLat = minLat < reporte.latitud ? minLat : reporte.latitud;
      maxLat = maxLat > reporte.latitud ? maxLat : reporte.latitud;
      minLng = minLng < reporte.longitud ? minLng : reporte.longitud;
      maxLng = maxLng > reporte.longitud ? maxLng : reporte.longitud;
    }

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        100.0, // padding
      ),
    );
  }

  void _showReporteDetails(Reporte reporte) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getEstadoIcon(reporte.estado),
                          color: _getEstadoColor(reporte.estado),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            reporte.titulo,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getEstadoColor(reporte.estado).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reporte.estado,
                        style: TextStyle(
                          color: _getEstadoColor(reporte.estado),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    if (reporte.foto.isNotEmpty) ...[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildSafeImageWidget(reporte.foto),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    _buildDetailRow('Código', reporte.codigo),
                    _buildDetailRow('Descripción', reporte.descripcion),
                    _buildDetailRow('Fecha', _formatDate(reporte.fecha)),
                    _buildDetailRow(
                      'Ubicación',
                      '${reporte.latitud.toStringAsFixed(6)}, ${reporte.longitud.toStringAsFixed(6)}',
                    ),

                    if (reporte.comentarioMinisterio != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Comentario del Ministerio:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(reporte.comentarioMinisterio!),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSafeImageWidget(String base64String) {
    try {
      String base64Data = base64String;
      if (base64String.contains(',')) {
        base64Data = base64String.split(',').last;
      }

      if (base64Data.isEmpty) {
        return const Icon(Icons.broken_image, color: Colors.grey);
      }

      while (base64Data.length % 4 != 0) {
        base64Data += '=';
      }

      final bytes = base64Decode(base64Data);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 50),
            ),
          );
        },
      );
    } catch (e) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.broken_image, size: 50),
        ),
      );
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  IconData _getEstadoIcon(String estado) {
    switch (estado.toLowerCase()) {
      case 'pendiente':
        return Icons.hourglass_empty;
      case 'en_proceso':
        return Icons.sync;
      case 'resuelto':
        return Icons.check_circle;
      case 'rechazado':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Color _getEstadoColor(String estado) {
    switch (estado.toLowerCase()) {
      case 'pendiente':
        return Colors.orange;
      case 'en_proceso':
        return Colors.blue;
      case 'resuelto':
        return Colors.green;
      case 'rechazado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Reportes'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadReportes),
          if (reportes.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.center_focus_strong),
              onPressed: _fitMarkersOnMap,
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error al cargar reportes'),
                  const SizedBox(height: 8),
                  Text(error!, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadReportes,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    if (reportes.isNotEmpty) {
                      _fitMarkersOnMap();
                    }
                  },
                  initialCameraPosition: _initialPosition,
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),

                // Leyenda
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Leyenda',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildLegendItem(Colors.orange, 'Pendiente'),
                        _buildLegendItem(Colors.blue, 'En Proceso'),
                        _buildLegendItem(Colors.green, 'Resuelto'),
                        _buildLegendItem(Colors.red, 'Rechazado'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
