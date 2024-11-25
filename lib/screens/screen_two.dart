import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'dart:convert'; // For JSON parsing

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  Map<String, dynamic>? alertData;

  @override
  void initState() {
    super.initState();
    _loadTestData(); // Load test JSON during development
  }

  Future<void> _loadTestData() async {
    try {
      // Load JSON file from assets
      final jsonString = await rootBundle.loadString('assets/test_alerts.json');
      setState(() {
        alertData = json.decode(jsonString);
      });
    } catch (e) {
      print("Error loading test data: $e");
      setState(() {
        alertData = null; // Handle errors gracefully
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (alertData == null) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(6, 12, 26, 1),
        appBar: AppBar(
          title: Text("Weather Alerts"),
          backgroundColor: Color.fromRGBO(14, 20, 33, 1),
        ),
        body: Center(
          child: CircularProgressIndicator(), // Show loader while data is loading
        ),
      );
    }

    final alerts = alertData!['alerts'] as List<dynamic>?;
    final cityName = alertData!['city_name'] ?? "Unknown City";
    final stateCode = alertData!['state_code'] ?? "";

    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 12, 26, 1),
      appBar: AppBar(
        title: Text("Weather Alerts for $cityName, $stateCode"),
        backgroundColor: Color.fromRGBO(14, 20, 33, 1),
      ),
      body: alerts == null || alerts.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, color: Colors.white, size: 80),
            SizedBox(height: 20),
            Text(
              "No active weather alerts at this time.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          final title = alert['title'] ?? "No Title";
          final description = alert['description'] ?? "No Description";
          final severity = alert['severity'] ?? "Unknown";
          final regions = alert['regions']?.join(", ") ?? "Unknown Regions";
          final effective = alert['effective_local'] ?? "N/A";
          final ends = alert['ends_local'] ?? "N/A";

          return Card(
            color: _getSeverityColor(severity),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Effective: ${_formatDateTime(effective)} - ${_formatDateTime(ends)}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Regions: $regions",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case "advisory":
        return Colors.blueAccent;
      case "warning":
        return Colors.orangeAccent;
      case "emergency":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(String dateTime) {
    try {
      final parsedDate = DateTime.parse(dateTime);
      return DateFormat('MMM dd, yyyy h:mm a').format(parsedDate);
    } catch (e) {
      return "Invalid date";
    }
  }
}
