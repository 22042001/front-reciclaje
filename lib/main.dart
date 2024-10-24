import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/home_selection_page.dart';
import 'screens/material_selection_page.dart'; // Asegúrate de importar esta nueva pantalla

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco-Mercio',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homeSelection': (context) => HomeSelectionPage(),
        '/materialSelection': (context) => MaterialSelectionPage(), // Nueva ruta para la selección de material
      },
    );
  }
}
