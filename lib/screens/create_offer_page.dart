import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../service/api_service.dart';
import 'home_selection_page.dart';

class CreateOfferPage extends StatefulWidget {
  final String materialId; // ID del material seleccionado
  final String materialName; // Nombre del material seleccionado

  CreateOfferPage({required this.materialId, required this.materialName});

  @override
  _CreateOfferPageState createState() => _CreateOfferPageState();
}

class _CreateOfferPageState extends State<CreateOfferPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  File? _image; // Para almacenar la imagen seleccionada
  final ApiService apiService = ApiService(); // Instancia de ApiService

  // Método para seleccionar una imagen desde la galería
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se seleccionó ninguna imagen.')),
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

  // Método para enviar la oferta a la API
  void _submitOffer() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty ||
        locationController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos y suba una imagen.')),
      );
      return;
    }

    // Llamada al método createOffer del ApiService
    bool success = await apiService.createOffer(
      titulo: titleController.text,
      descripcion: descriptionController.text,
      precio: priceController.text,
      cantidad: quantityController.text,
      ubicacion: locationController.text,
      tipoMaterialId: widget.materialId,
      imagen: _image!,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Oferta creada exitosamente.')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear la oferta.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Oferta: ${widget.materialName}'),
        backgroundColor: const Color.fromARGB(255, 214, 141, 6),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Llama al método de cerrar sesión
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo y Título
            Column(
              children: [
                Image.asset(
                  'assets/images/logoeco-2.png',
                  height: 80,
                ),
                SizedBox(height: 10),
                Text(
                  'Registro del Material',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Color del título
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            // Campo de Título
            _buildCustomTextField(
              controller: titleController,
              labelText: 'Título del producto',
            ),
            SizedBox(height: 15),
            // Campo de Descripción
            _buildCustomTextField(
              controller: descriptionController,
              labelText: 'Descripción',
              maxLines: 3,
            ),
            SizedBox(height: 15),
            // Campo de Precio
            _buildCustomTextField(
              controller: priceController,
              labelText: 'Precio',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            // Campo de Cantidad
            _buildCustomTextField(
              controller: quantityController,
              labelText: 'Cantidad del material',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            // Campo de Ubicación
            _buildCustomTextField(
              controller: locationController,
              labelText: 'Ubicación',
            ),
            SizedBox(height: 20),
            // Selector de imagen
            Text(
              'Imagen del producto',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 241, 239, 235),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: _image == null
                    ? Center(child: Icon(Icons.add_a_photo, color: Colors.grey, size: 50))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 30),
            // Botón para enviar la oferta
            Center(
              child: ElevatedButton(
                onPressed: _submitOffer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Color de fondo del botón
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Publicar Oferta',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.orange, size: 30),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeSelectionPage()),
                  );
                },
                tooltip: 'Inicio',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para construir TextFields personalizados
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[800], // Fondo más oscuro
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.orange),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      ),
    );
  }
}
