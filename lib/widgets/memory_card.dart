import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemoryCard extends StatelessWidget {
  final String imagePath;
  final DateTime timeAdded;
  final String caption;
  final VoidCallback onEdit;
  final VoidCallback onCaptionEdit;

  const MemoryCard({
    super.key,
    required this.imagePath,
    required this.timeAdded,
    required this.caption,
    required this.onEdit,
    required this.onCaptionEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Added on: ${DateFormat.yMMMd().add_jm().format(timeAdded)}',
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onCaptionEdit,
              child: Text(
                caption.isNotEmpty ? caption : 'Tap to add a caption...',
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Image'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
