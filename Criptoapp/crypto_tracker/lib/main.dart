import 'package:flutter/material.dart';
import 'coin_page.dart'; // Ruta corregida

void main() {
  runApp(const CryptoTrackerApp());
}

class CryptoTrackerApp extends StatelessWidget {
  const CryptoTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CoinPage(),
    );
  }
}
