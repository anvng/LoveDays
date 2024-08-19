import 'package:flutter/material.dart';
import 'package:lovedays/model/person_model.dart';

class EditScreen extends StatefulWidget {
  final Person person;

  const EditScreen({super.key, required this.person});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person.name);
    _dobController = TextEditingController(
        text: widget.person.dateOfBirth.toLocal().toString().split(' ')[0]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(
                  labelText: 'Date of Birth (yyyy-mm-dd)'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Update the Person object's properties
                  widget.person.name = _nameController.text;
                  try {
                    widget.person.dateOfBirth =
                        DateTime.parse(_dobController.text);
                  } catch (e) {
                    // Handle invalid date format
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid date format')),
                    );
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
