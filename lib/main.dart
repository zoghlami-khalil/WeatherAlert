import 'package:flutter/material.dart';
import 'screens/screen_one.dart';
import 'screens/screen_two.dart';
import 'widgets/sidebar_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainLayout(),
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

  final screens = [
    ScreenOne(),
    ScreenTwo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarWidget(
            onSelectScreen: setScreen,
            selectedScreenIndex: selectedScreenIndex,
          ),
          Expanded(child: screens[selectedScreenIndex]),
        ],
      ),
    );
  }
}
