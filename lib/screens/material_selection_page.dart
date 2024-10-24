import 'package:flutter/material.dart';

class MaterialSelectionPage extends StatelessWidget {
  final List<String> materials = [
    'Construcción',
    'Plásticos',
    'Papeles',
    'Metal',
    'Vidrios'
  ];

  final List<String> images = [
    'assets/images/materiales.png',
    'assets/images/consumo-de-plastico.jpg',
    'assets/images/papel.png',
    'assets/images/metales.jpg',
    'assets/images/vidrio.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Eco-Mercio'),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Lógica para el menú lateral
              },
            ),
          ],
        ),
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
              'Elige el tipo de material ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 255, 87, 34), // Color personalizado usando ARGB
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: materials.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navegar al formulario de creación de oferta
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CrearOfertaPage(material: materials[index])));
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
                              images[index],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              materials[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: const Color.fromARGB(255, 233, 157, 17), size: 30),
                onPressed: () {
                  Navigator.pushNamed(context, '/homeSelection'); // Redirige a la pantalla principal
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.orange),
                onPressed: () {
                  // Redirigir al perfil del usuario
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
