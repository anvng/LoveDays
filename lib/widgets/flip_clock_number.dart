import 'package:flutter/material.dart';

class FlipClockNumber extends StatelessWidget {
  final String value;

  const FlipClockNumber({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return _buildFlipTransition(child, animation);
      },
      child: _buildNumberContainer(value),
    );
  }

  Widget _buildFlipTransition(Widget child, Animation<double> animation) {
    final flipAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 3.1416 / 2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -3.1416 / 2, end: 0.0), weight: 50),
    ]).animate(animation);

    return AnimatedBuilder(
      animation: flipAnimation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationX(flipAnimation.value),
          alignment: Alignment.center,
          child: flipAnimation.value <= 3.1416 / 4
              ? child
              : Transform(
                  transform: Matrix4.rotationX(3.1416),
                  alignment: Alignment.center,
                  child: child,
                ),
        );
      },
      child: child,
    );
  }

  Widget _buildNumberContainer(String value) {
    return Container(
      key: ValueKey<String>(value),
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 211, 20, 144),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
