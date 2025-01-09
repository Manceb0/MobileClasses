import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '63c75fa442411b4868c2103ae6617ad3';
const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String locationMessage = "Press the button to get location";
  String weatherInfo = "Weather data will appear here";
  bool isLoading = false;  // Variable para el estado de carga

  Future<void> _getCurrentLocationAndWeather() async {
    setState(() => isLoading = true); // Activar loading al iniciar
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          locationMessage = "Location services are disabled.";
          isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            locationMessage = "Location permissions denied.";
            isLoading = false;
          });
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        locationMessage = "Lat: ${position.latitude}, Long: ${position.longitude}";
      });

      final response = await http.get(Uri.parse(
          '$openWeatherMapURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        var weatherData = jsonDecode(response.body);
        setState(() {
          weatherInfo =
          "🌡️ Temp: ${weatherData['main']['temp']}°C, ☁️ ${weatherData['weather'][0]['description']}";
        });
      } else {
        setState(() {
          weatherInfo = "Error fetching weather data";
        });
      }
    } catch (e) {
      setState(() => weatherInfo = "Error: $e");
    } finally {
      setState(() => isLoading = false); // Desactivar loading al finalizar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationMessage, style: TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            isLoading // Mostrar el indicador de carga cuando esté activo
                ? CircularProgressIndicator(color: Colors.white)
                : Text(weatherInfo, style: TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _getCurrentLocationAndWeather, // Deshabilitar el botón durante la carga
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
