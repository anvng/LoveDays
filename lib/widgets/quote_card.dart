import 'package:flutter/material.dart';
import '../data/quotes.dart';
import 'dart:math';

class QuoteCard extends StatelessWidget {
  final Random random = Random();

  QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    int randomIndex = random.nextInt(loveQuotes.length);
    String randomQuote = loveQuotes[randomIndex];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          randomQuote,
          style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
