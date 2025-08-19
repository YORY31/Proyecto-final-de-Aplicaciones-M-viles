import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListadoEquipo extends StatefulWidget {
  const ListadoEquipo({super.key});

  @override
  State<ListadoEquipo> createState() => _ListadoEquipoState();
}

class _ListadoEquipoState extends State<ListadoEquipo> {
  bool _cargando = true;
  List<dynamic> _equipo = [];

  Future<void> _cargarEquipo() async {
    final url = Uri.parse("https://adamix.net/medioambiente/docx/equipo");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      _equipo = jsonDecode(response.body);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${response.statusCode}"),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {
      _cargando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarEquipo();
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) return const Center(child: CircularProgressIndicator());
    if (_equipo.isEmpty) return const Center(child: Text("No hay datos para mostrar."));

    return ListView.builder(
      itemCount: _equipo.length,
      itemBuilder: (_, i) {
        final persona = _equipo[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: persona['foto'] != null && persona['foto'].isNotEmpty
                ? CircleAvatar(backgroundImage: NetworkImage(persona['foto']))
                : const CircleAvatar(child: Icon(Icons.person)),
            title: Text(persona['nombre'] ?? 'Sin nombre'),
            subtitle: Text("${persona['cargo'] ?? '--'}\n${persona['departamento'] ?? ''}"),
            isThreeLine: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(persona['nombre']),
                  content: Text(persona['biografia'] ?? 'Sin biografía'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cerrar"),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
