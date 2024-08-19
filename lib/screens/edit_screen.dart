import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lovedays/model/person_model.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  final Person person;

  const EditScreen({super.key, required this.person});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  DateTime? _selectedDate;
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person.name);
    _selectedDate = widget.person.dateOfBirth;
    _profileImagePath =
        widget.person.profileImage; // Assuming you have this field
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
      });
    }
  }

  void _saveChanges() {
    // Create a new Person object with updated information
    final updatedPerson = Person(
      name: _nameController.text,
      dateOfBirth: _selectedDate!,
      profileImage: _profileImagePath, // Update this field in the Person model
    );
    Navigator.pop(context, updatedPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Person Infor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : const AssetImage('lib/assets/images/male.jpg')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Date of Birth:'),
                TextButton(
                  onPressed: _pickDate,
                  child: Text(
                    _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : 'Select Date',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
