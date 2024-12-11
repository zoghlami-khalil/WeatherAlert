import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherAPI {
  static const String baseUrl = "https://api.weatherbit.io/v2.0";
  static const String apiKey = "API KEY HERE";

  static Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl/current?city=$city&key=$apiKey&units=I');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'][0];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching weather data: $e");
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> fetchForecast(String city) async {
    final url = Uri.parse(
        '$baseUrl/forecast/daily?city=$city&days=7&key=$apiKey&units=I');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching forecast data: $e");
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> fetchAlerts(String city) async {
    final url = Uri.parse("$baseUrl/alerts?city=$city&key=$apiKey");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['alerts'] != null) {
          return List<Map<String, dynamic>>.from(data['alerts']);
        }
      }
      return [];
    } catch (e) {
      print("Error fetching alerts: $e");
      return [];
    }
  }
}
