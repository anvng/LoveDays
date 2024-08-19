import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/memory_card.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  _MemoriesScreenState createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  List<XFile> memoryImages = [];
  final ImagePicker picker = ImagePicker();

  Future<void> _addMemoryImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          memoryImages.add(image);
        });
      }
    } catch (e) {
      // Handle errors or show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Pictures'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addMemoryImage,
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
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: memoryImages.length,
              itemBuilder: (context, index) {
                return MemoryCard(imagePath: memoryImages[index].path);
              },
            ),
    );
  }
}
