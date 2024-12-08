import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../utils/weather_api.dart';
import '../weather_app_state.dart';

class ScreenOne extends StatefulWidget {
  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  Map<String, dynamic>? weatherData;
  List<Map<String, dynamic>>? forecastData;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final initialCity = WeatherAppState.of(context)?.cityName ?? "Rochester";
    fetchWeatherAndForecast(initialCity);
  }

  Future<void> fetchWeatherAndForecast(String city) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      final weather = await WeatherAPI.fetchWeather(city);
      final forecast = await WeatherAPI.fetchForecast(city);

      if (mounted) {
        setState(() {
          weatherData = weather;
          forecastData = forecast?.skip(1).take(7).toList(); // Skip today, next 7 days
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          weatherData = null;
          forecastData = null;
          isLoading = false;
        });
      }
    }
  }


  void updateCityName(String newCity) {
    WeatherAppState.of(context)?.updateCityName(newCity);
    fetchWeatherAndForecast(newCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 12, 26, 1),
      body: Column(
        children: [
          SearchBarWidget(onSearch: updateCityName),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : weatherData == null || forecastData == null
                ? Center(
              child: Text(
                "Failed to fetch data. Please try again.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
                : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Weather Block
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(14, 20, 33, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main Weather Info
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Current Weather",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                weatherData!['city_name'] ?? "Unknown City",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "${weatherData!['temp'].round()}°F",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                weatherData!['weather']['description'] ?? "N/A",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Weather Details in Grid
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 200, // Fixed height for grid
                            child: GridView.count(
                              crossAxisCount: 2, // 2 columns
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 4, // Compact grid
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                _buildWeatherDetail(
                                    "Wind", "${weatherData!['wind_spd']} m/s"),
                                _buildWeatherDetail(
                                    "Humidity", "${weatherData!['rh']}%"),
                                _buildWeatherDetail(
                                    "UV Index", "${weatherData!['uv']}"),
                                _buildWeatherDetail(
                                    "Pressure", "${weatherData!['pres']} mb"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Week Forecast Block
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(14, 20, 33, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Week Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: forecastData!.map((day) {
                            return Column(
                              children: [
                                Text(
                                  _formatDate(day['valid_date']),
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                _buildWeatherIcon(day['weather']['icon']),
                                SizedBox(height: 8),
                                Text(
                                  day['weather']['description'] ?? "N/A",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${day['temp'].round()}°F",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(20, 25, 40, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherIcon(String? iconCode) {
    if (iconCode == null) {
      return Icon(Icons.help_outline, color: Colors.white, size: 30);
    }
    return Image.network(
      "https://www.weatherbit.io/static/img/icons/$iconCode.png",
      width: 30,
      height: 30,
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.day}/${parsedDate.month}";
    } catch (e) {
      return "N/A";
    }
  }
}
