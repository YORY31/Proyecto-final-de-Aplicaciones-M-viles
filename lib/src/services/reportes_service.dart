import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reporte_model.dart';
import '../screens/auth/services/auth_services.dart';

class ReportesService {
  static const String baseUrl = 'https://adamix.net/medioambiente';

  static Future<List<Reporte>> getReportes() async {
    print('📋 [REPORTES] Iniciando carga de reportes...');

    try {
      final headers = await AuthService.getAuthHeaders();
      print('📋 [REPORTES] Headers preparados para GET /reportes');

      final response = await http.get(
        Uri.parse('$baseUrl/reportes'),
        headers: headers,
      );

      print(
        '📡 [REPORTES] Respuesta GET /reportes - Status: ${response.statusCode}',
      );
      print('📡 [REPORTES] Cuerpo de respuesta: ${response.body}');

      if (response.statusCode == 200) {
        print('✅ [REPORTES] Reportes obtenidos exitosamente');
        final List<dynamic> data = json.decode(response.body);
        print('📊 [REPORTES] Cantidad de reportes: ${data.length}');
        return data.map((item) => Reporte.fromJson(item)).toList();
      } else if (response.statusCode == 401) {
        print('🔐 [REPORTES] Error 401 - Token inválido o expirado');
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente.');
      } else {
        print('❌ [REPORTES] Error ${response.statusCode} obteniendo reportes');
        throw Exception('Error al cargar reportes: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 [REPORTES] Excepción obteniendo reportes: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('Error de conexión: $e');
    }
  }

  static Future<Reporte> createReporte(CreateReportRequest request) async {
    try {
      print('📤 [ReportesService] Iniciando createReporte...');
      print('📤 [ReportesService] Request data: ${request.toJson()}');
      final headers = await AuthService.getAuthHeaders();
      print('📤 [ReportesService] Headers obtenidos: $headers');

      // Try form data encoding for create report
      final formHeaders = Map<String, String>.from(headers);
      formHeaders['Content-Type'] = 'application/x-www-form-urlencoded';

      final response = await http.post(
        Uri.parse('$baseUrl/reportes'),
        headers: formHeaders,
        body: request.toJson(),
      );

      print(
        '📤 [ReportesService] Respuesta recibida - Código: ${response.statusCode}',
      );
      print('📤 [ReportesService] Cuerpo de respuesta: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        print('📤 [ReportesService] Reporte creado exitosamente!');
        return Reporte.fromJson(data);
      } else if (response.statusCode == 401) {
        print('❌ [ReportesService] Error 401 - Token no válido o expirado');
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente.');
      } else {
        print(
          '❌ [ReportesService] Error ${response.statusCode}: ${response.body}',
        );
        throw Exception('Error al crear reporte: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 [ReportesService] Exception en createReporte: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('Error de conexión: $e');
    }
  }
}
