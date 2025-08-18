import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://adamix.net/medioambiente/auth';

  // Login del usuario
  static Future<Map<String, dynamic>> login(
    String correo,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'accept': 'application/json'},
        encoding: Encoding.getByName('utf-8'),
        body: {'correo': correo.trim(), 'password': password},
      );
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'success': false,
        'statusCode': 500,
        'data': {'mensaje': 'Error de conexión: $e'},
      };
    }
  }

  // Recuperar contraseña
  static Future<Map<String, dynamic>> recoverPassword(String correo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/recover'),
        headers: {'accept': 'application/json'},
        encoding: Encoding.getByName('utf-8'),
        body: {'correo': correo},
      );

      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'success': false,
        'statusCode': 500,
        'data': {'mensaje': 'Error de conexión: $e'},
      };
    }
  }

  // Restablecer contraseña
  static Future<Map<String, dynamic>> resetPassword(
    String correo,
    String codigo,
    String nuevaPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reset'),
        headers: {'accept': 'application/json'},
        encoding: Encoding.getByName('utf-8'),
        body: {
          'correo': correo,
          'codigo': codigo,
          'nueva_password': nuevaPassword,
        },
      );

      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'success': false,
        'statusCode': 500,
        'data': {'mensaje': 'Error de conexión: $e'},
      };
    }
  }
}
