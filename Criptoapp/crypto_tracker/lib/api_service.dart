import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinApiService {
  final String apiKey = '010ae29f-8826-4c42-98db-879e4c682ae2'; // Tu clave API CoinAPI
  final String baseUrl = 'https://rest.coinapi.io/v1/exchangerate';

  /// Obtener la tasa de cambio entre dos criptomonedas
  Future<Map<String, dynamic>> getExchangeRate(String baseCurrency, String quoteCurrency) async {
    final url = Uri.parse('$baseUrl/$baseCurrency/$quoteCurrency');
    try {
      final response = await http.get(
        url,
        headers: {'X-CoinAPI-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': 'Error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error de conexión: $e'};
    }
  }
}
