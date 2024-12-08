import 'package:flutter/material.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String role = "Emergency Manager"; // Default role

  final Map<String, String> staticUsers = {
    "admin1": "root", // Username: admin1, Password: root
    "admin2": "root" // Username: admin2, Password: root
  };

  void _attemptLogin() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (staticUsers[username] == password) {
      // Navigate to MainLayout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainLayout(),
        ),
      );
    } else {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid username or password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 12, 26, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Name
            Text(
              "Severe Weather Events Alerts",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Role Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      role = "Emergency Manager";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: role == "Emergency Manager"
                        ? Colors.blueAccent
                        : Colors.grey,
                  ),
                  child: Text("Emergency Manager"),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      role = "Meteorologist";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: role == "Meteorologist" ? Colors.blueAccent : Colors.grey,
                  ),
                  child: Text("Meteorologist"),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Login Form
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(14, 20, 33, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Username Field
                  TextField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Login Button
                  ElevatedButton(
                    onPressed: _attemptLogin,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      primary: Colors.blueAccent,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
