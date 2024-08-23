import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovedays/screens/details_screen.dart';
import 'package:lovedays/screens/home_screen.dart';
import 'package:lovedays/screens/memories_screen.dart';
import 'package:lovedays/widgets/person_infor_card.dart'; // Import your screen

void main() {
  testWidgets(
      'HomeScreen displays correct initial state and handles navigation',
      (WidgetTester tester) async {
    // Build the app and load the HomeScreen
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify that the initial state of the screen is correct
    expect(find.text('Mede Day ❤️'), findsOneWidget); // AppBar title
    expect(find.text('View Details'), findsOneWidget); // Button text
    expect(find.text('View Memories'), findsOneWidget); // Button text

    // Check if the days together is displayed correctly
    expect(find.textContaining('Days'),
        findsOneWidget); // Replace with actual text or use a more specific matcher

    // Verify PersonInfoCard widgets are present
    expect(find.byType(PersonInfoCard),
        findsNWidgets(2)); // Assuming there are 2 PersonInfoCard widgets

    // Simulate tapping the 'View Details' button
    await tester.tap(find.text('View Details'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify that navigation occurred (you would need to set up a route for '/details')
    // Assuming you use Navigator in your app to push named routes
    expect(find.byType(DetailsScreen),
        findsOneWidget); // Replace DetailsScreen with your actual details screen widget

    // Simulate tapping the 'View Memories' button
    await tester.tap(find.text('View Memories'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify that navigation occurred (you would need to set up a route for '/memories')
    expect(find.byType(MemoriesScreen),
        findsOneWidget); // Replace MemoriesScreen with your actual memories screen widget
  });
}
