import 'package:flutter/material.dart';

class WeatherAppState extends InheritedWidget {
  final String cityName;
  final Function(String) updateCityName;

  WeatherAppState({
    required this.cityName,
    required this.updateCityName,
    required Widget child,
  }) : super(child: child);

  static WeatherAppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WeatherAppState>();
  }

  @override
  bool updateShouldNotify(covariant WeatherAppState oldWidget) {
    return cityName != oldWidget.cityName;
  }
}
