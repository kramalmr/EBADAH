import 'dart:convert';
import 'package:http/http.dart' as http;

class QiblaService {
  Future<double?> getQiblaDirection(double latitude, double longitude) async {
    final url = Uri.parse(
      'http://api.aladhan.com/v1/qibla/$latitude/$longitude',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['direction']?.toDouble();
    } else {
      throw Exception('Gagal mengambil arah kiblat');
    }
  }
}
