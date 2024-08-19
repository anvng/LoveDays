import '../utils/date_utils.dart';

class Person {
  late final String name;
  late final DateTime dateOfBirth;

  String get zodiacSign => getZodiacSign(dateOfBirth);
  int get age => getCurrentAge(dateOfBirth);
  String get numerology => calculateNumerology(name, dateOfBirth);

  Person({
    required this.name,
    required this.dateOfBirth,
  });
}
