import 'package:flutter/material.dart';
import 'create_offer_page.dart';
import '../service/api_service.dart'; 

class MaterialSelectionPage extends StatelessWidget {
  final ApiService apiService = ApiService(); 

  // Lista de materiales con ID, nombre y ruta de imagen
  final List<Map<String, dynamic>> materials = [
    {'id': '1', 'name': 'Construcción', 'image': 'assets/images/materiales.png'},
    {'id': '2', 'name': 'Plásticos', 'image': 'assets/images/consumo-de-plastico.jpg'},
    {'id': '3', 'name': 'Papeles', 'image': 'assets/images/papel.png'},
    {'id': '4', 'name': 'Metales', 'image': 'assets/images/metales.jpg'},
    {'id': '5', 'name': 'Vidrios', 'image': 'assets/images/vidrio.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 104, 10),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logoeco-2.png', 
          height: 35,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () async {
              await apiService.logout(); // Llama al método de cerrar sesión
              Navigator.pushReplacementNamed(context, '/login'); 
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de búsqueda
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            // Título de la sección
            const Text(
              'Elige el tipo de material',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 20),
            // Lista de materiales
            Expanded(
              child: ListView.builder(
                itemCount: materials.length,
                itemBuilder: (context, index) {
                  final material = materials[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateOfferPage(
                            materialId: material['id'], // Pasa el ID del material
                            materialName: material['name'], // Pasa el nombre del material
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              material['image'],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              material['name'],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi Perfil',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/homeSelection'); // Ir a Home
          } else if (index == 1) {
            Navigator.pushNamed(context, '/profile'); // Ir a Mi Perfil
          }
        },
      ),
    );
  }
}
