import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_alert/main.dart';
import 'package:weather_alert/screens/login_screen.dart';
import 'package:weather_alert/screens/screen_one.dart';
import 'package:weather_alert/screens/screen_two.dart';
import 'package:weather_alert/widgets/sidebar_widget.dart';
import 'package:weather_alert/weather_app_state.dart';

void main() {
  group('Weather Alert App Tests', () {
    Widget buildTestableApp(Widget child) {
      return WeatherAppState(
        cityName: "Rochester",
        updateCityName: (newCity) {},
        child: MaterialApp(home: child),
      );
    }

    testWidgets('Login page loads correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.text("Severe Weather Events Alerts"), findsOneWidget);
      expect(find.text("Emergency Manager"), findsOneWidget);
      expect(find.text("Meteorologist"), findsOneWidget);
      expect(find.text("Username"), findsOneWidget);
      expect(find.text("Password"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
    });

    testWidgets('Login succeeds with correct credentials', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      await tester.enterText(find.byType(TextField).at(0), "admin1");
      await tester.enterText(find.byType(TextField).at(1), "root");
      await tester.tap(find.text("Login"));
      await tester.pumpAndSettle();

      expect(find.byType(MainLayout), findsOneWidget);
    });

    testWidgets('Search for a city and verify weather data', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableApp(MainLayout()));
      await tester.pumpAndSettle();

      expect(find.text("Rochester"), findsOneWidget);

      await tester.enterText(find.byType(TextField), "Los Angeles");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text("Los Angeles"), findsOneWidget);
    });

    testWidgets('Navigate to alerts and verify data for Los Angeles', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableApp(MainLayout()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.notification_important));
      await tester.pumpAndSettle();

      expect(find.text("Weather Alerts for Los Angeles"), findsOneWidget);
    });
  });
}
