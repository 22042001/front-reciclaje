import 'dart:convert';
import 'package:http/http.dart' as http;

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
      return data['token']; // Retorna el token JWT
    } else {
      print('Error de login: ${response.body}');
      return null;
    }
  }

  // Método para registrar un nuevo usuario
  Future<bool> register(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/users');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      print('Registro exitoso');
      return true;
    } else {
      print('Error de registro: ${response.body}');
      return false;
    }
  }
}
