import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = 'd9eda6f3c6a7855a317cd95311e80343';
  static const String city = 'Colombo';
  static const String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

  static Future<Map<String, dynamic>?> fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Failed to load weather data");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
