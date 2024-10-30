import 'package:flutter/material.dart';
import 'package:psf2/screens/list_publications_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/home_selection_page.dart';
import 'screens/material_selection_page.dart';
import 'screens/create_offer_page.dart';


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
        '/materialSelection': (context) => MaterialSelectionPage(),
        '/createOffer': (context) => CreateOfferPage(materialId: '1', materialName: 'default'),
        '/listPublications': (context) => ListPublicationsPage(), // Nueva ruta para la lista de ofertas

      },
    );
  }
}