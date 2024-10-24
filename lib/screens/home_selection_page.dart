import 'package:flutter/material.dart';
import 'material_selection_page.dart'; // Asegúrate de importar la nueva pantalla
import 'login_page.dart'; // Importa la pantalla de inicio de sesión
import '../service/api_service.dart'; // Asegúrate de importar tu servicio API

class HomeSelectionPage extends StatelessWidget {
  final ApiService apiService = ApiService(); // Inicializa el servicio API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 98, 8),
        title: Text('Eco-Mercio', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: const Color.fromARGB(255, 11, 11, 11)),
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
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logoeco-2.png', // Asegúrate de tener esta imagen en tu carpeta de assets
              height: 80,
            ),
            SizedBox(height: 20),
            Text(
              '¿En qué te podemos ayudar hoy?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            // Botón "Comprar"
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de lista de publicaciones
                Navigator.pushNamed(context, '/listPublications');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Color de fondo del botón
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Comprar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Color del texto
                ),
              ),
            ),
            SizedBox(height: 20),
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
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Vender',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Color del texto
                ),
              ),
            ),
            SizedBox(height: 40),
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
