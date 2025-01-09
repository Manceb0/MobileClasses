import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/utilities/constants.dart';

const String apiKey = '63c75fa442411b4868c2103ae6617ad3';
const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = ''; // Variable para almacenar la ciudad ingresada
  String weatherInfo = "Weather data will appear here"; // Mostrar resultado

  Future<void> getWeatherData(String cityName) async {
    final url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var weatherData = jsonDecode(response.body);
        setState(() {
          weatherInfo = "🌡️ Temp: ${weatherData['main']['temp']}°C, ☁️ ${weatherData['weather'][0]['description']}";
        });
      } else {
        setState(() {
          weatherInfo = "Error: City not found!";
        });
      }
    } catch (e) {
      setState(() {
        weatherInfo = "Error: Unable to fetch data!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(Icons.location_city, color: Colors.white),
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  if (cityName.isNotEmpty) {
                    getWeatherData(cityName);
                  } else {
                    setState(() {
                      weatherInfo = "Please enter a city name!";
                    });
                  }
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                weatherInfo,
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
