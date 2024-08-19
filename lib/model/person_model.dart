import 'package:lovedays/utils/date_utils.dart';

class Person {
  final String name;
  final DateTime dateOfBirth;
  final DateTime? firstDate;
  final String? profileImage;

  Person({
    required this.name,
    required this.dateOfBirth,
    this.firstDate,
    this.profileImage,
  });

  // Adding copyWith method
  Person copyWith({
    String? name,
    DateTime? dateOfBirth,
    DateTime? firstDate,
    String? profileImage,
  }) {
    return Person(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      firstDate: firstDate ?? this.firstDate,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  String get zodiacSign {
    return getZodiacSign(dateOfBirth);
  }

  String get numerology {
    return calculateNumerology(name, dateOfBirth);
  }
}
