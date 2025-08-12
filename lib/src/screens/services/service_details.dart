






import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/src/models/service_model.dart';

class ServiceDetails extends StatelessWidget {
  final ServiceModel service;
  const ServiceDetails({
    super.key,
    required this.service
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.nombre),
        backgroundColor: Colors.greenAccent,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Descripcion del servicio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                service.descripcion,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 17,
        color:Colors.greenAccent,
      ),
    );
  }
}