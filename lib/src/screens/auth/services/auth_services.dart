import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://adamix.net/medioambiente/auth';
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';

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

      final result = {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };

      // Store token if login is successful
      if (result['success'] && result['data']['token'] != null) {
        await _storeToken(result['data']['token']);
        await _storeUserData(result['data']);
      }

      return result;
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

  // Store authentication token
  static Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Store user data
  static Future<void> _storeUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonEncode(userData));
  }

  // Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get stored user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout - clear stored data
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
  }

  // Get authentication headers for API requests
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }
}
