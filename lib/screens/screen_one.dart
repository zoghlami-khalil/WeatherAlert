import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';

class ScreenOne extends StatefulWidget {
  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  String cityName = "Troy";

  void updateCityName(String newCity) {
    setState(() {
      cityName = newCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final forecast = [
      {'day': "Mon", 'temp': 26, 'icon': Icons.wb_sunny},
      {'day': "Tue", 'temp': 24, 'icon': Icons.cloud},
      {'day': "Wed", 'temp': 22, 'icon': Icons.wb_cloudy},
      {'day': "Thu", 'temp': 20, 'icon': Icons.water_drop},
      {'day': "Fri", 'temp': 21, 'icon': Icons.wb_sunny},
      {'day': "Sat", 'temp': 19, 'icon': Icons.cloud},
      {'day': "Sun", 'temp': 18, 'icon': Icons.wb_cloudy},
    ];

    final highlights = {
      'Wind': '12 km/h',
      'Humidity': '78%',
      'UV Index': '5',
      'Pressure': '1013 hPa',
    };

    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 12, 26, 1),
      body: Column(
        children: [
          SearchBarWidget(onSearch: updateCityName),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weather Info and 7-Day Forecast
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cityName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "26.0°C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Sunny",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(14, 20, 33, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(12),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: forecast.map((day) {
                                  return Column(
                                    children: [
                                      Icon(day['icon'] as IconData, color: Colors.white, size: 30),
                                      SizedBox(height: 8),
                                      Text(
                                        day['day'] as String,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "${day['temp']}°",
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
                  SizedBox(width: 16),
                  // Highlights Box in Grid Format
                  Container(
                    constraints: BoxConstraints(
                      minWidth: 200,
                      maxWidth: 400,
                    ),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(14, 20, 33, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Today Highlights",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        GridView.count(
                          crossAxisCount: 2, // 2 columns
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.4, // Adjusted for better fit
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: highlights.entries.map((entry) {
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
                                    entry.key,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    entry.value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
}
