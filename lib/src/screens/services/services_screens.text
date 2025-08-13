




import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/src/models/service_model.dart';
import 'package:proyectofinalmovil/src/screens/services/service_details.dart';
import 'package:proyectofinalmovil/src/services/api_consumer_service.dart';
import 'package:proyectofinalmovil/src/widgets/custom_widgets.dart';

class ServicesScreens extends StatefulWidget {
  const ServicesScreens({super.key});

  @override
  createState() => _ServicesScreensState();
}

class _ServicesScreensState extends State<ServicesScreens> {
  final _apiConsumer = ApiConsumerService();
  List<ServiceModel> _services = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      final services = await _apiConsumer.getServices();
      setState(() {
        _services = services;
      });
    } catch (e) {
      if(!mounted) return;
      showScaffoldMessenger(context, 'Error al cargar los servicios: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child:  _buildBody() ,
      ),
      bottomNavigationBar: Container(
        height: 17,
        color:Colors.greenAccent,
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        return listServiceItem(  
          service.nombre,
          service.icono,
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ServiceDetails(service: service)
              )
            );
          }
        );
      }
    );
  }
}