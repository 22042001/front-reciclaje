import 'package:flutter/material.dart';
import 'create_offer_page.dart';

class MaterialSelectionPage extends StatelessWidget {
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
        title: Text('Eco-Mercio'),
        backgroundColor: const Color.fromARGB(255, 227, 104, 10),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de búsqueda
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: const Color.fromARGB(137, 243, 141, 7)),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Título de la sección
            Text(
              'Elige el tipo de material',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 255, 87, 34),
              ),
            ),
            SizedBox(height: 20),
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
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
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
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Container(
          height: 50,
          child: IconButton(
            icon: Icon(Icons.home, color: const Color.fromARGB(255, 233, 157, 17), size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/homeSelection');
            },
          ),
        ),
      ),
    );
  }
}
