import 'package:flutter/material.dart';
import 'material_selection_page.dart'; 
import 'login_page.dart'; 
import '../service/api_service.dart'; 

class HomeSelectionPage extends StatelessWidget {
  final ApiService apiService = ApiService(); // Inicializa el servicio API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 104, 10),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logoeco-2.png', // Logo en el centro del AppBar
          height: 35,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color.fromARGB(255, 3, 3, 3)),
            onPressed: () async {
              // Lógica para cerrar sesión
              await apiService.logout(); // Llama a la función de cierre de sesión
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Redirige a la pantalla de inicio de sesión
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logoeco-2.png', // Imagen del logo
              height: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              '¿En qué te podemos ayudar hoy?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Botón "Comprar"
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de lista de publicaciones
                Navigator.pushNamed(context, '/listPublications');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Color de fondo del botón
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Comprar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Color del texto
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón "Vender"
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de selección de tipo de material
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MaterialSelectionPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Color de fondo del botón
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Vender',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Color del texto
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Icono de reciclaje
            Image.asset(
              'assets/images/imagen-inicio.png', // Asegúrate de tener esta imagen en tu carpeta de assets
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
