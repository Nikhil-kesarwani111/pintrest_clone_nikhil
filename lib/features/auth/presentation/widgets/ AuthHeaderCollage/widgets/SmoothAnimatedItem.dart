import 'dart:math' as math;
import 'package:flutter/material.dart';


class SmoothAnimatedItem extends StatelessWidget {
  final Animation<Offset> slideAnim;
  final Animation<double> fadeAnim;
  final Animation<double> scaleAnim;
  final AnimationController breathingController;
  final double randomOffset;
  final String url;
  final double width;
  final double height;
  final double scaleRange;
  final double verticalDistance;

  const SmoothAnimatedItem({super.key,
    required this.slideAnim,
    required this.fadeAnim,
    required this.scaleAnim,
    required this.breathingController,
    required this.randomOffset,
    required this.url,
    required this.width,
    required this.height,
    required this.scaleRange,
    required this.verticalDistance,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnim,
      child: SlideTransition(
        position: slideAnim,
        child: ScaleTransition(
          scale: scaleAnim,

          child: AnimatedBuilder(
            animation: breathingController,
            builder: (context, child) {
              final double t = breathingController.value * 2 * math.pi;
              final double wave = math.sin(t + randomOffset); // -1.0 to 1.0

              final double scaleValue = 1.0 + (wave * scaleRange);
              final double yValue = wave * verticalDistance;

              return Transform.translate(
                offset: Offset(0, yValue),
                child: Transform.scale(
                  scale: scaleValue,
                  child: child,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.network(
                url,
                width: width,
                height: height,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[200]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}