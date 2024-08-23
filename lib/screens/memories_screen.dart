import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/background_container.dart';
import '../widgets/memory_card.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  _MemoriesScreenState createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  final List<Map<String, dynamic>> memoryImages = [];
  final ImagePicker picker = ImagePicker();

  Future<void> _addMemoryImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (kDebugMode) {
          print('Selected image path: ${image.path}');
        }
        setState(() {
          memoryImages.insert(0, {
            'imagePath': image.path,
            'timeAdded': DateTime.now(),
            'caption': '',
          });
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _editMemory(int index) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        memoryImages[index]['imagePath'] = pickedFile.path;
        memoryImages[index]['timeAdded'] =
            DateTime.now(); // Update the time to the current time
      });
    }
  }

  void _editCaption(int index) async {
    String? newCaption =
        await _showCaptionDialog(memoryImages[index]['caption']);
    if (newCaption != null) {
      setState(() {
        memoryImages[index]['caption'] = newCaption;
      });
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
        body: memoryImages.isEmpty
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
                itemCount: memoryImages.length,
                itemBuilder: (context, index) {
                  return MemoryCard(
                    imagePath: memoryImages[index]['imagePath'],
                    timeAdded: memoryImages[index]['timeAdded'],
                    caption: memoryImages[index]['caption'],
                    onEdit: () => _editMemory(index),
                    onCaptionEdit: () => _editCaption(index),
                  );
                },
              ),
      ),
    );
  }
}
