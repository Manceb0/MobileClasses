import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/location_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud),
            tooltip: 'Go to Loading Screen',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoadingScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            tooltip: 'Go to Location Screen',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.location_city),
            tooltip: 'Enter City',
            onPressed: () async {
              //  CityScreen
              final cityName = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CityScreen()),
              );

              if (cityName != null && cityName.isNotEmpty) {
                // ✅ Imprime la ciudad o inicia alguna función para obtener el clima
                print('Ciudad seleccionada: $cityName');
                _showSnackBar(context, 'City selected: $cityName');
                // Aquí podrías realizar una petición a la API para obtener el clima
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to the Weather App! 🌤️\nUse the buttons above to navigate.',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Función para mostrar un SnackBar con la ciudad seleccionada
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
