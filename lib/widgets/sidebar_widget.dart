import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final Function(int) onSelectScreen;
  final int selectedScreenIndex;

  SidebarWidget({
    required this.onSelectScreen,
    required this.selectedScreenIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: Color.fromRGBO(14, 20, 33, 1),
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Static Icon
          Icon(Icons.thunderstorm, color: Colors.lightBlueAccent, size: 30),
          SizedBox(height: 10),
          Divider(color: Colors.white24, thickness: 1), // Separator line
          SizedBox(height: 20),

          // Home Icon
          GestureDetector(
            onTap: () => onSelectScreen(0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedScreenIndex == 0 ? Colors.white24 : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.home, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),

          // Alert Icon
          GestureDetector(
            onTap: () => onSelectScreen(1),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedScreenIndex == 1 ? Colors.white24 : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.notification_important, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
