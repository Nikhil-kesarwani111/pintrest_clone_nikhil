import 'dart:math';
import 'package:flutter/material.dart';

class RadialBubble extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final double angleDegrees;
  final double radius;
  final double bubbleSize;
  final Animation<double> scaleAnimation;

  const RadialBubble({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.angleDegrees,
    required this.radius,
    required this.bubbleSize,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    // Convert degrees to radians for positioning
    final double radians = angleDegrees * pi / 180;

    // Calculate offset from center (Standard trig: x=cos, y=sin)
    // We flip Y (-sin) because screen coordinates go down, but unit circle goes up
    final double offsetX = radius * cos(radians);
    final double offsetY = radius * -sin(radians);

    return Transform.translate(
      offset: Offset(offsetX - (bubbleSize / 2), offsetY - (bubbleSize / 2)),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Transform.scale(
          scale: isSelected ? 1.2 : 1.0,
          child: Container(
            width: bubbleSize,
            height: bubbleSize,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}