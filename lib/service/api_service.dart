import 'dart:convert';
import 'dart:io';
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
    final url = Uri.parse('$baseUrl/register');

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

 // Método para crear una oferta
  Future<bool> createOffer({
    required String titulo,
    required String descripcion,
    required String precio,
    required String cantidad,
    required String ubicacion,
    required String tipoMaterialId,
    required File imagen,
  }) async {
    final url = Uri.parse('$baseUrl/offers');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Obtiene el token almacenado

    if (token == null) {
      print('Error: Token no encontrado');
      return false;
    }

    // Prepara la solicitud multipart para enviar la imagen y otros datos
    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    // Agrega los campos de texto al cuerpo de la solicitud
    request.fields['título'] = titulo;
    request.fields['descripción'] = descripcion;
    request.fields['precio'] = precio;
    request.fields['cantidad'] = cantidad;
    request.fields['ubicación'] = ubicacion;
    request.fields['tipo_material_id'] = tipoMaterialId;

    // Agrega la imagen a la solicitud
    var imageStream = http.ByteStream(imagen.openRead());
    var imageLength = await imagen.length();

    var multipartFile = http.MultipartFile(
      'images[]', // Asegúrate de que el nombre coincida con lo esperado en el back-end
      imageStream,
      imageLength,
      filename: imagen.path.split('/').last,
    );

    request.files.add(multipartFile);

    // Envía la solicitud y maneja la respuesta
    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        print('Oferta creada exitosamente');
        return true;
      } else {
        var responseBody = await response.stream.bytesToString();
        print('Error al crear la oferta: ${response.statusCode} - $responseBody');
        return false;
      }
    } catch (e) {
      print('Excepción durante la creación de la oferta: $e');
      return false;
    }
  }

   // Método para obtener la lista de ofertas
  Future<List<dynamic>?> getOffers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Obtiene el token almacenado

    if (token == null) {
      print('Error: Token no encontrado');
      return null;
    }

    final url = Uri.parse('$baseUrl/offers');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error al obtener las ofertas: ${response.body}');
      return null;
    }
  }
}
