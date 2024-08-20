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
  DateTime? _selectedFirstDate;
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person.name);
    _selectedDate = widget.person.dateOfBirth;
    _selectedFirstDate = widget.person.firstDate;
    _profileImagePath = widget.person.profileImage;
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

  Future<void> _pickFirstDate() async {
    DateTime? pickedFirstDate = await showDatePicker(
      context: context,
      initialDate: _selectedFirstDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedFirstDate != null) {
      setState(() {
        _selectedFirstDate = pickedFirstDate;
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
    final updatedPerson = Person(
      name: _nameController.text,
      dateOfBirth: _selectedDate!,
      firstDate: _selectedFirstDate, // Update the first date
      profileImage: _profileImagePath,
    );
    Navigator.pop(context, updatedPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Person Info'),
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
                    : const AssetImage('lib/assets/images/default_profile.png')
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
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('First Date:'),
                TextButton(
                  onPressed: _pickFirstDate,
                  child: Text(
                    _selectedFirstDate != null
                        ? '${_selectedFirstDate!.day}/${_selectedFirstDate!.month}/${_selectedFirstDate!.year}'
                        : 'Select First Date',
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
