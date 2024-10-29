import 'package:flutter/material.dart';
import '../service/api_service.dart';

class ListPublicationsPage extends StatefulWidget {
  @override
  _ListPublicationsPageState createState() => _ListPublicationsPageState();
}

class _ListPublicationsPageState extends State<ListPublicationsPage> {
  final ApiService apiService = ApiService();
  List<dynamic> offers = [];

  @override
  void initState() {
    super.initState();
    _loadOffers(); // Cargar las ofertas al iniciar la vista
  }

  // Método para cargar las ofertas desde la API
  void _loadOffers() async {
    List<dynamic>? result = await apiService.getOffers();
    if (result != null) {
      setState(() {
        offers = result;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener las ofertas')),
      );
    }
  }

  // Método para cerrar sesión
  void _logout() async {
    await apiService.logout(); // Llama al método de logout en ApiService
    Navigator.pushReplacementNamed(context, '/login'); // Redirige al login
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sesión cerrada exitosamente.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas Publicaciones'),
        backgroundColor: const Color.fromARGB(255, 234, 98, 8),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Llama al método de cerrar sesión
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: offers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                final imageUrl = (offer['images'] != null && offer['images'].isNotEmpty)
                    ? 'http://10.0.2.2:8000/storage/${offer['images'][0]['ruta_imagen']}'
                    : null;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen de la oferta
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          image: imageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imageUrl == null
                            ? Icon(Icons.image, color: Colors.grey, size: 50)
                            : null,
                      ),
                      SizedBox(width: 12),
                      // Información de la oferta
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer['título'] ?? 'Sin título',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              offer['descripción'] ?? 'Sin descripción',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  offer['ubicación'] ?? 'Ubicación desconocida',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Precio: ${offer['precio'] ?? 'N/A'}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        items: [
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