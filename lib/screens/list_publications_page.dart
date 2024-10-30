import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class ListPublicationsPage extends StatefulWidget {
  const ListPublicationsPage({Key? key}) : super(key: key);

  @override
  ListPublicationsPageState createState() => ListPublicationsPageState();
}

class ListPublicationsPageState extends State<ListPublicationsPage> {
  final ApiService apiService = ApiService();
  List<dynamic> offers = [];
  List<dynamic> filteredOffers = [];
  TextEditingController searchController = TextEditingController();

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
        filteredOffers = result; // Inicialmente, las ofertas filtradas son las mismas
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al obtener las ofertas')),
        );
      }
    }
  }

  // Método para formatear la fecha
  String formatFecha(String fecha) {
    try {
      DateTime date = DateTime.parse(fecha);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return 'Fecha desconocida';
    }
  }

  // Método para filtrar las ofertas según el texto de búsqueda
  void _filterOffers(String query) {
    List<dynamic> tempOffers = offers.where((offer) {
      final title = (offer['título'] ?? '').toLowerCase();
      final description = (offer['descripción'] ?? '').toLowerCase();
      final location = (offer['ubicación'] ?? '').toLowerCase();
      return title.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase()) ||
          location.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredOffers = tempOffers;
    });
  }

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
            icon: const Icon(Icons.logout, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () async {
              await apiService.logout(); // Cierra sesión
              Navigator.pushReplacementNamed(context, '/login'); // Redirige al login
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) => _filterOffers(value),
                      decoration: const InputDecoration(
                        hintText: 'Buscar por título, descripción o ubicación...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: Colors.orange),
                ],
              ),
            ),
          ),
          // Mensaje de concientización de reciclaje
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              '¡Reciclar es más que una acción, es nuestra responsabilidad! '
              'Fomenta el reciclaje y contribuye a un planeta más limpio y sostenible.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Lista de publicaciones
          Expanded(
            child: filteredOffers.isEmpty
                ? const Center(child: Text('No hay publicaciones disponibles'))
                : ListView.builder(
                    itemCount: filteredOffers.length,
                    itemBuilder: (context, index) {
                      final offer = filteredOffers[index];
                      final imageUrl = (offer['images'] != null && offer['images'].isNotEmpty)
                          ? 'http://10.0.2.2:8000/storage/${offer['images'][0]['ruta_imagen']}'
                          : null;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
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
                                  ? const Icon(Icons.image, color: Colors.grey, size: 50)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            // Información de la oferta
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer['título'] ?? 'Sin título',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Descripción: ${offer['descripción'] ?? 'Sin descripción'}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Ubicación: ${offer['ubicación'] ?? 'Ubicación desconocida'}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Publicado: ${formatFecha(offer['created_at'])}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'Precio: ${offer['precio'] ?? 'N/A'}',
                                        style: const TextStyle(
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
          ),
        ],
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
            Navigator.pushNamed(context, '/profile'); // Lógica para ir a Mi Perfil
          }
        },
      ),
    );
  }
}
