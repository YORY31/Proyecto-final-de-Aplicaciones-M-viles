import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistroVoluntariado extends StatefulWidget {
  const RegistroVoluntariado({super.key});

  @override
  State<RegistroVoluntariado> createState() => _RegistroVoluntariadoState();
}

class _RegistroVoluntariadoState extends State<RegistroVoluntariado> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cedulaCtrl = TextEditingController();
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _apellidoCtrl = TextEditingController();
  final TextEditingController _correoCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _telefonoCtrl = TextEditingController();

  Future<void> _registrarVoluntario() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse("https://adamix.net/medioambiente/docx/voluntarios");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "cedula": _cedulaCtrl.text,
        "nombre": _nombreCtrl.text,
        "apellido": _apellidoCtrl.text,
        "correo": _correoCtrl.text,
        "password": _passwordCtrl.text,
        "telefono": _telefonoCtrl.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("✅ Solicitud registrada con éxito"),
        backgroundColor: Colors.green,
      ));
      _cedulaCtrl.clear();
      _nombreCtrl.clear();
      _apellidoCtrl.clear();
      _correoCtrl.clear();
      _passwordCtrl.clear();
      _telefonoCtrl.clear();
    } else if (response.statusCode == 409) {
      final error = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("⚠️ Conflicto: ${error['error']}"),
        backgroundColor: Colors.orange,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("❌ Error: ${response.statusCode}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(controller: _cedulaCtrl, decoration: const InputDecoration(labelText: 'Cédula')),
            TextFormField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
            TextFormField(controller: _apellidoCtrl, decoration: const InputDecoration(labelText: 'Apellido')),
            TextFormField(controller: _correoCtrl, decoration: const InputDecoration(labelText: 'Correo electrónico')),
            TextFormField(controller: _passwordCtrl, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
            TextFormField(controller: _telefonoCtrl, decoration: const InputDecoration(labelText: 'Teléfono')),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _registrarVoluntario,
              icon: const Icon(Icons.send),
              label: const Text('Registrar voluntario'),
            ),
          ],
        ),
      ),
    );
  }
}
