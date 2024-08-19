import 'package:flutter/material.dart';
import '../model/person_model.dart';

class PersonInfoCard extends StatelessWidget {
  final Person person;

  const PersonInfoCard({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(person.name),
          Text('Age: ${person.age}'),
          Text('Date of Birth: ${person.dateOfBirth}'),
          Text('Zodiac: ${person.zodiacSign}'),
          Text('Numerology: ${person.numerology}'),
        ],
      ),
    );
  }
}
