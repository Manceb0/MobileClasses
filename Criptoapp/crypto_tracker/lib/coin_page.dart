import 'package:flutter/material.dart';
import 'package:crypto_tracker/api_service.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({Key? key}) : super(key: key);

  @override
  CoinPageState createState() => CoinPageState();
}

class CoinPageState extends State<CoinPage> {
  final CoinApiService apiService = CoinApiService();
  double exchangeRate = 0.0;
  String baseCurrency = 'BTC';
  String quoteCurrency = 'USD';

  List<String> currencies = ['BTC', 'ETH', 'LTC', 'USD', 'EUR'];

  Future<void> fetchExchangeRate() async {
    final response = await apiService.getExchangeRate(baseCurrency, quoteCurrency);
    if (response['success']) {
      setState(() {
        exchangeRate = response['data']['rate'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Crypto Exchange Rate',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Selección de monedas
            DropdownButton<String>(
              value: baseCurrency,
              items: currencies.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  baseCurrency = value!;
                  fetchExchangeRate();
                });
              },
            ),
            const SizedBox(height: 10),

            DropdownButton<String>(
              value: quoteCurrency,
              items: currencies.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  quoteCurrency = value!;
                  fetchExchangeRate();
                });
              },
            ),

            const SizedBox(height: 20),
            Text('1 $baseCurrency = $exchangeRate $quoteCurrency',
                style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: fetchExchangeRate,
              child: const Text('Actualizar Tasa'),
            ),
          ],
        ),
      ),
    );
  }
}
