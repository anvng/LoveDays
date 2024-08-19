import 'package:flutter/material.dart';
import 'package:lovedays/model/person_model.dart';
import 'package:lovedays/widgets/quote_card.dart';
import 'package:lovedays/screens/details_screen.dart';
import 'package:lovedays/screens/memories_screen.dart';
import 'package:lovedays/screens/edit_screen.dart'; // Import EditScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Person malePerson =
        Person(name: 'An Dep', dateOfBirth: DateTime(2000, 5, 15));
    final Person femalePerson =
        Person(name: 'Hong Meo', dateOfBirth: DateTime(2000, 7, 10));
    final DateTime meetDate = DateTime(2023, 4, 7);
    int daysTogether = DateTime.now().difference(meetDate).inDays;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mede Day ❤️'),
      ),
      body: PageView(
        children: [
          _buildHomePage(context, malePerson, femalePerson, daysTogether),
          const DetailsScreen(),
          const MemoriesScreen(),
        ],
      ),
    );
  }

  Widget _buildHomePage(BuildContext context, Person malePerson,
      Person femalePerson, int daysTogether) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: _buildPersonSection(context, malePerson, 'male.jpg')),
              Expanded(
                  child:
                      _buildPersonSection(context, femalePerson, 'female.jpg')),
            ],
          ),
          const SizedBox(height: 20),
          _buildHeartbeatCircle(daysTogether),
          const SizedBox(height: 20),
          QuoteCard(),
        ],
      ),
    );
  }

  Widget _buildPersonSection(
      BuildContext context, Person person, String imageName) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(person: person),
                ),
              );
            },
            child: ClipOval(
              child: Image.asset(
                'lib/assets/images/$imageName',
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
          Text('Zodiac: ${person.zodiacSign}',
              style: const TextStyle(fontSize: 16)),
          Text('Numerology: ${person.numerology}',
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

// Helper method to format the date
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}'; // Format as DD/MM/YYYY
  }

  Widget _buildHeartbeatCircle(int daysTogether) {
    return HeartbeatCircle(daysTogether: daysTogether);
  }
}

class HeartbeatCircle extends StatefulWidget {
  final int daysTogether;

  const HeartbeatCircle({Key? key, required this.daysTogether})
      : super(key: key);

  @override
  _HeartbeatCircleState createState() => _HeartbeatCircleState();
}

class _HeartbeatCircleState extends State<HeartbeatCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Center(
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: _controller,
            curve: Curves.elasticInOut,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(60),
            child: Text(
              '${widget.daysTogether} Days',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
