import 'package:flutter/material.dart';
import 'package:lovedays/screens/home_screen.dart';
import 'package:lovedays/screens/details_screen.dart';
import 'package:lovedays/screens/edit_screen.dart';
import 'package:lovedays/screens/memories_screen.dart';
import 'package:lovedays/model/person_model.dart';

void main() {
  runApp(const LoveDayCounterApp());
}

class LoveDayCounterApp extends StatelessWidget {
  const LoveDayCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Love Day Counter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'PlayfairDisplay_Regular',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 20.0),
          bodyMedium: TextStyle(fontSize: 18.0),
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomeScreen(),
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case '/edit':
            final person = args?['person'] as Person;
            return MaterialPageRoute(
              builder: (context) => EditScreen(person: person),
            );
          case '/details':
            return MaterialPageRoute(
                builder: (context) => const DetailsScreen());
          case '/memories':
            return MaterialPageRoute(
                builder: (context) => const MemoriesScreen());
          default:
            return null;
        }
      },
    );
  }
}
