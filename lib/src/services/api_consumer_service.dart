


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyectofinalmovil/src/models/news_model.dart';
import 'package:proyectofinalmovil/src/models/service_model.dart';

class ApiConsumerService {

  final String _baseUri = 'https://adamix.net/medioambiente/';

  Future<List<NewsModel>> getNews() async {
    try {
      final response = await http.get(Uri.parse('$_baseUri/noticias'));
      if(response.statusCode == 200) {
        List<dynamic> news = jsonDecode(response.body);
        return news.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar noticias ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ServiceModel>> getServices() async {
    try{
      final response = await http.get(Uri.parse('$_baseUri/servicios'));

      if(response.statusCode == 200) {
        final List<dynamic> services = jsonDecode(response.body);
        return services.map((json) => ServiceModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar servicios ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}