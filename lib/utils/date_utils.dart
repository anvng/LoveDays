String getZodiacSign(DateTime dateOfBirth) {
  int day = dateOfBirth.day;
  int month = dateOfBirth.month;

  if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
    return "Aquarius";
  } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
    return "Pisces";
  } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
    return "Aries";
  } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
    return "Taurus";
  } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
    return "Gemini";
  } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
    return "Cancer";
  } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
    return "Leo";
  } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
    return "Virgo";
  } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
    return "Libra";
  } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
    return "Scorpio";
  } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
    return "Sagittarius";
  } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
    return "Capricorn";
  } else {
    return "Unknown";
  }
}

int getCurrentAge(DateTime dateOfBirth) {
  DateTime now = DateTime.now();
  int age = now.year - dateOfBirth.year;
  if (now.month < dateOfBirth.month ||
      (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
    age--;
  }
  return age;
}

String calculateNumerology(String name, DateTime dateOfBirth) {
  int sum = 0;

  // Calculate the sum of the letters in the name (A=1, B=2, ..., Z=26)
  name = name
      .toUpperCase()
      .replaceAll(RegExp(r'[^A-Z]'), ''); // Remove non-alphabetic characters
  for (int i = 0; i < name.length; i++) {
    sum += name.codeUnitAt(i) - 64; // 'A' is 65 in ASCII, so subtract 64
  }

  // Add the digits of the birth date
  sum += dateOfBirth.day + dateOfBirth.month + dateOfBirth.year;

  // Reduce to a single digit
  while (sum > 9) {
    sum = sum.toString().split('').map(int.parse).reduce((a, b) => a + b);
  }

  return sum.toString();
}
