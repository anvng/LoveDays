import 'dart:io';
import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  final String imagePath;

  const MemoryCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Add a caption...', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
