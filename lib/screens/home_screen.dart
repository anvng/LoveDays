import 'package:flutter/material.dart';
import 'package:lovedays/model/person_model.dart';
import 'package:lovedays/widgets/quote_card.dart';
import 'package:lovedays/screens/details_screen.dart';
import 'package:lovedays/screens/memories_screen.dart';
import 'package:lovedays/screens/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Person malePerson;
  late Person femalePerson;
  DateTime meetDate = DateTime(2023, 4, 7);
  int daysTogether = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    malePerson = Person(
      name: '🌵 An Dep ♂️',
      dateOfBirth: DateTime(2000, 5, 15),
      firstDate: meetDate,
    );
    femalePerson = Person(
      name: '🌷 Hong Meo ♀️',
      dateOfBirth: DateTime(2000, 7, 10),
      firstDate: meetDate,
    );
    daysTogether = DateTime.now().difference(meetDate).inDays;

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updatePerson(Person updatedPerson) {
    setState(() {
      if (updatedPerson.name == malePerson.name) {
        malePerson = updatedPerson;
      } else {
        femalePerson = updatedPerson;
      }
      meetDate = updatedPerson.firstDate ?? meetDate;
      daysTogether = DateTime.now().difference(meetDate).inDays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mede Day ❤️'),
      ),
      body: PageView(
        children: [
          _buildHomePage(context),
          const DetailsScreen(),
          const MemoriesScreen(),
        ],
      ),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildPersonSection(context, malePerson)),
              Expanded(child: _buildPersonSection(context, femalePerson)),
            ],
          ),
          const SizedBox(height: 20),
          _buildHeartbeatCircle(),
          const SizedBox(height: 20),
          QuoteCard(),
        ],
      ),
    );
  }

  Widget _buildPersonSection(BuildContext context, Person person) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final updatedPerson = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(person: person),
                ),
              );
              if (updatedPerson != null) {
                _updatePerson(updatedPerson);
              }
            },
            child: ClipOval(
              child: Image.asset(
                'lib/assets/images/${person.name == malePerson.name ? "male.jpg" : "female.jpg"}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            person.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Age: ${person.age}', style: const TextStyle(fontSize: 16)),
          Text('Birth: ${_formatDate(person.dateOfBirth)}',
              style: const TextStyle(fontSize: 16)),
          Text('First Date: ${_formatDate(person.firstDate)}',
              style: const TextStyle(fontSize: 16)),
          Text('Zodiac: ${person.zodiacSign}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildHeartbeatCircle() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: meetDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          setState(() {
            meetDate = pickedDate;
            daysTogether = DateTime.now().difference(meetDate).inDays;
            malePerson = malePerson.copyWith(firstDate: meetDate);
            femalePerson = femalePerson.copyWith(firstDate: meetDate);
          });
        }
      },
      child: ScaleTransition(
        scale: _controller,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.favorite,
              size: 200,
              color: Colors.red,
            ),
            Text(
              '$daysTogether',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }
}
