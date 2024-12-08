import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/weather_api.dart';

class ScreenTwo extends StatefulWidget {
  final String cityName;

  ScreenTwo({required this.cityName});

  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  List<Map<String, dynamic>>? alerts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAlerts(widget.cityName);
  }

  Future<void> fetchAlerts(String city) async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedAlerts = await WeatherAPI.fetchAlerts(city);
      setState(() {
        alerts = fetchedAlerts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        alerts = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 12, 26, 1),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Weather Alerts for ${widget.cityName}"),
            Row(
              children: [
                _buildLegendItem("Advisory", Colors.greenAccent),
                SizedBox(width: 8),
                _buildLegendItem("Watch", Colors.orangeAccent),
                SizedBox(width: 8),
                _buildLegendItem("Warning", Colors.redAccent),
              ],
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(14, 20, 33, 1),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : alerts == null || alerts!.isEmpty
          ? _buildNoAlerts()
          : _buildAlertsList(),
    );
  }

  Widget _buildNoAlerts() {
    return Center(
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
    );
  }

  Widget _buildAlertsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: alerts!.length,
      itemBuilder: (context, index) {
        final alert = alerts![index];
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
          child: ExpansionTile(
            title: Column(
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
                SizedBox(height: 4),
                Text(
                  "Severity: $severity",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Regions: $regions",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case "advisory":
        return Colors.greenAccent;
      case "watch":
        return Colors.orangeAccent;
      case "warning":
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
