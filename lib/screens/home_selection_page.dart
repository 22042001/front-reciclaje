import 'package:flutter/material.dart';

class HomeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Eco-Mercio', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg', // Asegúrate de tener esta imagen en tu carpeta de assets
              height: 80,
            ),
            SizedBox(height: 20),
            Text(
              'En que te podemos ayudar hoy?',
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
                // Lógica para navegar a la vista de lista de publicaciones
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
                // Lógica para navegar a la vista de crear publicación
                Navigator.pushNamed(context, '/createOffer');
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          padding: EdgeInsets.all(10),
          child: IconButton(
            icon: Icon(Icons.home, color: Colors.orange, size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Volver a la pantalla de inicio de sesión
            },
          ),
        ),
      ),
    );
  }
}
