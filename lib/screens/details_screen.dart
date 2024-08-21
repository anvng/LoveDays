import 'package:flutter/material.dart';
import 'package:lovedays/widgets/flip_clock_number.dart';
import 'dart:async';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final DateTime meetDate = DateTime(2023, 4, 7);
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = _currentTime.difference(meetDate);
    int years = duration.inDays ~/ 365;
    int months = (duration.inDays % 365) ~/ 30;
    int weeks = (duration.inDays % 30) ~/ 7;
    int days = duration.inDays % 7;

    String hours = _currentTime.hour.toString().padLeft(2, '0');
    String minutes = _currentTime.minute.toString().padLeft(2, '0');
    String seconds = _currentTime.second.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Detailed Breakdown'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Years: $years', style: const TextStyle(fontSize: 20)),
            Text('Months: $months', style: const TextStyle(fontSize: 20)),
            Text('Weeks: $weeks', style: const TextStyle(fontSize: 20)),
            Text('Days: $days', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown, // Adjust
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlipClockNumber(value: hours.substring(0, 1)),
                    const SizedBox(width: 4),
                    FlipClockNumber(value: hours.substring(1, 2)),
                    const Text(':', style: TextStyle(fontSize: 40)),
                    FlipClockNumber(value: minutes.substring(0, 1)),
                    const SizedBox(width: 4),
                    FlipClockNumber(value: minutes.substring(1, 2)),
                    const Text(':', style: TextStyle(fontSize: 40)),
                    FlipClockNumber(value: seconds.substring(0, 1)),
                    const SizedBox(width: 4),
                    FlipClockNumber(value: seconds.substring(1, 2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
