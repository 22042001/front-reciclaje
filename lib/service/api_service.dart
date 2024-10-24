import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api'; // Cambia la URL si es necesario

  // Método para iniciar sesión y obtener el token
  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      // Guarda el token en el almacenamiento local
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return token;
    } else {
      print('Error de login: ${response.body}');
      return null;
    }
  }

  // Método para registrar un nuevo usuario
  Future<bool> register(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/register'); // Ajuste de la URL para el registro

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error en el registro: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Excepción durante el registro: $e');
      return false;
    }
  }

  // Método para cerrar sesión
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final url = Uri.parse('$baseUrl/logout');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Sesión cerrada exitosamente');
      } else {
        print('Error al cerrar sesión: ${response.body}');
      }

      // Eliminar el token del almacenamiento local
      await prefs.remove('token');
    }
  }
}
