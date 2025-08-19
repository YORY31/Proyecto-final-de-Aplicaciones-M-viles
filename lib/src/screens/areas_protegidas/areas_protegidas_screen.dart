import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyectofinalmovil/src/screens/areas_protegidas/areas_protegidas.dart';

class AreasProtegidasScreen extends StatefulWidget {
  const AreasProtegidasScreen({super.key});
  @override
  createState() => _AreasProtegidasScreenState();
}

class _AreasProtegidasScreenState extends State<AreasProtegidasScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<AreaProtegida> _areas = [];
  List<AreaProtegida> _filteredAreas = [];
  bool _isLoading = true;
  String _searchQuery = '';
  GoogleMapController? mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAreasProtegidas();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Cargar datos de la API
  Future<void> _loadAreasProtegidas() async {
    try {
      // final response = await http.get(
      //   Uri.parse('https://adamix.net/medioambiente/areas_protegidas'),
      // );
      // Simular delay de red
      await Future.delayed(Duration(seconds: 1));

      // Datos simulados de áreas protegidas de República Dominicana
      final String responseBody = '''[
        {
          "id": "1",
          "nombre": "Parque Nacional Los Haitises",
          "tipo": "Parque Nacional",
          "descripcion": "Los Haitises es un parque nacional localizado en la costa noreste de la República Dominicana, en las provincias Monte Plata, Hato Mayor y Samaná. Comprende una superficie terrestre de 1,600 km² y una superficie marina de 26,500 hectáreas. Se caracteriza por sus formaciones kársticas, cuevas con pictografías y petroglifos taínos, y una rica biodiversidad marina y terrestre.",
          "ubicacion": "Samaná, Monte Plata, Hato Mayor",
          "superficie": "1,600 km²",
          "imagen": "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=500&h=300&fit=crop",
          "latitud": 19.05,
          "longitud": -69.62
        },
        {
          "id": "2",
          "nombre": "Parque Nacional Armando Bermúdez",
          "tipo": "Parque Nacional",
          "descripcion": "Ubicado en la Cordillera Central, este parque protege las cuencas hidrográficas más importantes del país. Incluye el Pico Duarte, la montaña más alta del Caribe. Es hogar de especies endémicas de flora y fauna, y constituye una importante reserva de agua dulce para la nación.",
          "ubicacion": "La Vega, Santiago, San Juan",
          "superficie": "766 km²",
          "imagen": "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=300&fit=crop",
          "latitud": 19.02,
          "longitud": -70.60
        },
        {
          "id": "3",
          "nombre": "Parque Nacional José del Carmen Ramírez",
          "tipo": "Parque Nacional",
          "descripcion": "Adyacente al Parque Armando Bermúdez, protege parte de la Cordillera Central y las nacientes de importantes ríos. Cuenta con bosques nublados y pinares únicos en el Caribe, además de ser refugio de especies endémicas como la cigua palmera y el zorzal de La Selle.",
          "ubicacion": "San Juan, La Vega",
          "superficie": "764 km²",
          "imagen": "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=500&h=300&fit=crop",
          "latitud": 18.92,
          "longitud": -70.75
        },
        {
          "id": "4",
          "nombre": "Parque Nacional del Este",
          "tipo": "Parque Nacional",
          "descripcion": "Localizado en el extremo sureste del país, incluye la Isla Saona. Es famoso por sus playas de arena blanca, arrecifes coralinos y bosque seco tropical. Alberga especies como la iguana de Ricord y el manatí antillano. Es uno de los destinos turísticos más visitados del país.",
          "ubicacion": "La Altagracia",
          "superficie": "420 km²",
          "imagen": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&h=300&fit=crop",
          "latitud": 18.20,
          "longitud": -68.75
        },
        {
          "id": "5",
          "nombre": "Parque Nacional Jaragua",
          "tipo": "Parque Nacional",
          "descripcion": "El parque nacional más grande del Caribe insular, ubicado en el suroeste del país. Incluye las islas Beata y Alto Velo. Protege ecosistemas de bosque seco, humedales y arrecifes coralinos. Es hábitat crítico para las tortugas marinas, iguanas de Ricord y numerosas aves migratorias.",
          "ubicacion": "Pedernales, Barahona",
          "superficie": "1,374 km²",
          "imagen": "https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=500&h=300&fit=crop",
          "latitud": 17.85,
          "longitud": -71.45
        },
        {
          "id": "6",
          "nombre": "Parque Nacional Sierra de Bahoruco",
          "tipo": "Parque Nacional",
          "descripcion": "Situado en la frontera con Haití, este parque protege los bosques nublados y secos de la Sierra de Bahoruco. Es reconocido por su alto nivel de endemismo, especialmente en orquídeas y aves. Forma parte de la Reserva de la Biosfera Jaragua-Bahoruco-Enriquillo.",
          "ubicacion": "Pedernales, Independencia, Barahona",
          "superficie": "1,125 km²",
          "imagen": "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=300&fit=crop",
          "latitud": 18.20,
          "longitud": -71.65
        },
        {
          "id": "7",
          "nombre": "Santuario de Mamíferos Marinos de la República Dominicana",
          "tipo": "Santuario Marino",
          "descripcion": "Área marina protegida que incluye el Banco de la Plata y el Banco de la Navidad. Es el área de reproducción más importante de las ballenas jorobadas en el Atlántico Norte. Durante la temporada de apareamiento (enero-marzo), miles de ballenas visitan estas aguas.",
          "ubicacion": "Aguas territoriales del norte",
          "superficie": "32,000 km²",
          "imagen": "https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=500&h=300&fit=crop",
          "latitud": 20.00,
          "longitud": -69.00
        },
        {
          "id": "8",
          "nombre": "Parque Nacional Monte Cristi",
          "tipo": "Parque Nacional",
          "descripcion": "Localizado en el extremo noroeste del país, incluye El Morro, formación rocosa icónica. Protege ecosistemas de manglar, bosque seco y marino. Es importante sitio de anidación para tortugas marinas y refugio de aves migratorias. Incluye los Cayos Siete Hermanos.",
          "ubicacion": "Monte Cristi",
          "superficie": "530 km²",
          "imagen": "https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=500&h=300&fit=crop",
          "latitud": 19.85,
          "longitud": -71.65
        },
        {
          "id": "9",
          "nombre": "Reserva Científica Laguna de Rincón",
          "tipo": "Reserva Científica",
          "descripcion": "El lago de agua dulce más grande de las Antillas. Importante humedal que alberga cocodrilos americanos, manatíes antillanos y numerosas especies de aves acuáticas. Es sitio Ramsar por su importancia para la conservación de humedales.",
          "ubicacion": "Samaná",
          "superficie": "48 km²",
          "imagen": "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=300&fit=crop",
          "latitud": 19.20,
          "longitud": -69.40
        },
        {
          "id": "10",
          "nombre": "Parque Nacional Lago Enriquillo",
          "tipo": "Parque Nacional",
          "descripcion": "Protege el lago hipersalino más grande del Caribe y el punto más bajo de las Antillas (44 metros bajo el nivel del mar). Hábitat único de cocodrilos americanos, iguanas de Ricord y flamencos rosados. Forma parte de la Reserva de la Biosfera.",
          "ubicacion": "Independencia, Bahoruco",
          "superficie": "265 km²",
          "imagen": "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=300&fit=crop",
          "latitud": 18.50,
          "longitud": -71.75
        }
      ]''';

      // Simular la respuesta HTTP
      http.Response response = http.Response(responseBody, 200);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          _areas = jsonData
              .map((json) => AreaProtegida.fromJson(json))
              .toList();
          _filteredAreas = _areas;
          _isLoading = false;
          _createMarkers();
        });
      } else {
        throw Exception('Error al cargar datos');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Error al cargar las áreas protegidas: $e');
    }
  }

  // Crear marcadores para el mapa
  void _createMarkers() {
    _markers = _areas.map((area) {
      return Marker(
        markerId: MarkerId(area.id),
        position: LatLng(area.latitud, area.longitud),
        infoWindow: InfoWindow(
          title: area.nombre,
          snippet: area.tipo,
          onTap: () => _showAreaDetail(area),
        ),
        onTap: () => _showAreaDetail(area),
      );
    }).toSet();
  }

  // Filtrar áreas según la búsqueda
  void _filterAreas(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredAreas = _areas;
      } else {
        _filteredAreas = _areas
            .where(
              (area) =>
                  area.nombre.toLowerCase().contains(query.toLowerCase()) ||
                  area.tipo.toLowerCase().contains(query.toLowerCase()) ||
                  area.ubicacion.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  // Mostrar diálogo de error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Mostrar detalle del área
  void _showAreaDetail(AreaProtegida area) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AreaDetailScreen(area: area)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Áreas Protegidas'),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.list), text: 'Lista'),
            Tab(icon: Icon(Icons.map), text: 'Mapa'),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [_buildListView(), _buildMapView()],
            ),
    );
  }

  // Vista de lista
  Widget _buildListView() {
    return Column(
      children: [
        // Barra de búsqueda
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar áreas protegidas...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: _filterAreas,
          ),
        ),
        // Lista de áreas
        Expanded(
          child: _filteredAreas.isEmpty
              ? Center(
                  child: Text(
                    _searchQuery.isEmpty
                        ? 'No hay áreas protegidas disponibles'
                        : 'No se encontraron resultados para "$_searchQuery"',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _filteredAreas.length,
                  itemBuilder: (context, index) {
                    final area = _filteredAreas[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: area.imagen.isNotEmpty
                              ? NetworkImage(area.imagen)
                              : null,
                          backgroundColor: Colors.green[100],
                          child: area.imagen.isEmpty
                              ? Icon(Icons.nature, color: Colors.green)
                              : null,
                        ),
                        title: Text(
                          area.nombre,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo: ${area.tipo}'),
                            Text('Ubicación: ${area.ubicacion}'),
                            if (area.superficie.isNotEmpty)
                              Text('Superficie: ${area.superficie}'),
                          ],
                        ),
                        isThreeLine: true,
                        onTap: () => _showAreaDetail(area),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Vista de mapa
  Widget _buildMapView() {
    if (_areas.isEmpty) {
      return Center(
        child: Text(
          'No hay ubicaciones disponibles',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // Calcular el centro del mapa basado en las coordenadas
    double centerLat =
        _areas.map((e) => e.latitud).reduce((a, b) => a + b) / _areas.length;
    double centerLng =
        _areas.map((e) => e.longitud).reduce((a, b) => a + b) / _areas.length;

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(centerLat, centerLng),
        zoom: 8.0,
      ),
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
    );
  }
}

// Pantalla de detalle del área protegida
class AreaDetailScreen extends StatelessWidget {
  final AreaProtegida area;

  const AreaDetailScreen({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(area.nombre), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del área
            if (area.imagen.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(area.imagen),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green[100],
                ),
                child: Icon(Icons.nature, size: 80, color: Colors.green),
              ),

            SizedBox(height: 20),

            // Información básica
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información General',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow('Nombre', area.nombre),
                    _buildInfoRow('Tipo', area.tipo),
                    _buildInfoRow('Ubicación', area.ubicacion),
                    if (area.superficie.isNotEmpty)
                      _buildInfoRow('Superficie', area.superficie),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Descripción
            if (area.descripcion.isNotEmpty)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descripción',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        area.descripcion,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 16),

            // Coordenadas y mapa pequeño
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ubicación',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow('Latitud', area.latitud.toString()),
                    _buildInfoRow('Longitud', area.longitud.toString()),
                    SizedBox(height: 16),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(area.latitud, area.longitud),
                          zoom: 12.0,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(area.id),
                            position: LatLng(area.latitud, area.longitud),
                            infoWindow: InfoWindow(
                              title: area.nombre,
                              snippet: area.tipo,
                            ),
                          ),
                        },
                        zoomControlsEnabled: false,
                        scrollGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(flex: 3, child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
