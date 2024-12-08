import 'package:flutter/material.dart';
import 'screens/screen_one.dart';
import 'screens/screen_two.dart';
import 'widgets/sidebar_widget.dart';
import 'weather_app_state.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String cityName = "Rochester";

  void updateCityName(String newCity) {
    setState(() {
      cityName = newCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeatherAppState(
      cityName: cityName,
      updateCityName: updateCityName,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(), // Start with the LoginScreen
      ),
    );
  }
}

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedScreenIndex = 0;

  void setScreen(int index) {
    setState(() {
      selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherAppState = WeatherAppState.of(context)!;

    return Scaffold(
      body: Row(
        children: [
          SidebarWidget(
            onSelectScreen: setScreen,
            selectedScreenIndex: selectedScreenIndex,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (selectedScreenIndex == 0) {
                  return ScreenOne(); // State managed by WeatherAppState
                } else {
                  return ScreenTwo(
                    cityName: weatherAppState.cityName, // Pass state to ScreenTwo
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
