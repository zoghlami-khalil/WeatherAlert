import 'package:flutter/material.dart';

class WeatherInfoWidget extends StatelessWidget {
  final String cityName;
  final double currentTemp;
  final String weatherCondition;
  final List<Map<String, dynamic>> forecast;
  final Map<String, String> highlights;

  WeatherInfoWidget({
    required this.cityName,
    required this.currentTemp,
    required this.weatherCondition,
    required this.forecast,
    required this.highlights,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cityName,
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "${currentTemp.toStringAsFixed(1)}°C",
          style: TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          weatherCondition,
          style: TextStyle(color: Colors.white70, fontSize: 20),
        ),
        SizedBox(height: 16),
        // 7-Day Forecast Box
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromRGBO(14, 20, 33, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: forecast.map((day) {
              return Column(
                children: [
                  Text(
                    day['day'],
                    style: TextStyle(color: Colors.white70),
                  ),
                  Icon(day['icon'], color: Colors.white),
                  Text(
                    "${day['temp']}°",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
