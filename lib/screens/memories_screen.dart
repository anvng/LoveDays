import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lovedays/model/memory_model.dart';

import '../widgets/background_container.dart';
import '../widgets/memory_card.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  _MemoriesScreenState createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  late Box<Memory> memoryBox;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    memoryBox = Hive.box<Memory>('memories');
  }

  Future<void> _addMemoryImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final newMemory = Memory(
        imagePath: image.path,
        caption: '',
        timeAdded: DateTime.now(),
      );
      setState(() {
        memoryBox.add(newMemory);
      });
    }
  }

  void _editMemory(int index) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final memory = memoryBox.getAt(index);
      if (memory != null) {
        memory
          ..imagePath = pickedFile.path
          ..timeAdded = DateTime.now()
          ..save();
        setState(() {});
      }
    }
  }

  void _editCaption(int index) async {
    final memory = memoryBox.getAt(index);
    if (memory != null) {
      String? newCaption = await _showCaptionDialog(memory.caption);
      if (newCaption != null) {
        memory
          ..caption = newCaption
          ..save();
        setState(() {});
      }
    }
  }

  Future<String?> _showCaptionDialog(String currentCaption) async {
    TextEditingController controller =
        TextEditingController(text: currentCaption);
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Caption'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter your caption'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Memory Pictures'),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addMemoryImage,
              tooltip: 'Add Memory Picture',
            ),
          ],
        ),
        body: memoryBox.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo, size: 60, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        'No memories yet. Add some!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: memoryBox.length,
                itemBuilder: (context, index) {
                  final memory = memoryBox.getAt(index);
                  return MemoryCard(
                    imagePath: memory!.imagePath,
                    timeAdded: memory.timeAdded,
                    caption: memory.caption,
                    onEdit: () => _editMemory(index),
                    onCaptionEdit: () => _editCaption(index),
                  );
                },
              ),
      ),
    );
  }
}
