import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/prod.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Foreground content (the rest of the app)
        child,
      ],
    );
  }
}
