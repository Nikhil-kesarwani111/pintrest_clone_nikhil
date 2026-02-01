import 'package:flutter/material.dart';

class RotatingFourDots extends StatefulWidget {
  final Color dotColor;

  const RotatingFourDots({
    super.key,
    this.dotColor = Colors.white,
  });

  @override
  State<RotatingFourDots> createState() => _RotatingFourDotsState();
}

class _RotatingFourDotsState extends State<RotatingFourDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Top Left
            Transform.translate(offset: const Offset(-7, -7), child: _buildDot()),
            // Top Right
            Transform.translate(offset: const Offset(7, -7), child: _buildDot()),
            // Bottom Right
            Transform.translate(offset: const Offset(7, 7), child: _buildDot()),
            // Bottom Left
            Transform.translate(offset: const Offset(-7, 7), child: _buildDot()),
          ],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: widget.dotColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

