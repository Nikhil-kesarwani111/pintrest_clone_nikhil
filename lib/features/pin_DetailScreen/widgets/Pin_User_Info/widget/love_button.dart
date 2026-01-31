import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../Provider/pin_interaction_provider.dart';

class LoveButton extends ConsumerWidget {
  final int pinId;
  final bool isLoved;
  final int loveCount;

  const LoveButton({
    super.key,
    required this.pinId,
    required this.isLoved,
    required this.loveCount,
  });

  void _showLoveTooltip(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - 10,
        top: offset.dy - 45.h(context),
        child: _AnimatedLoveTooltip(onFinish: () => entry.remove()),
      ),
    );

    Overlay.of(context).insert(entry);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(pinInteractionProvider(pinId).notifier);

    return Row(
      children: [
        Builder(
          builder: (iconContext) => GestureDetector(
            onTap: () {
              notifier.toggleLove();
              if (!isLoved) _showLoveTooltip(iconContext);
            },
            child: Icon(
              isLoved ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isLoved ? AppColors.primary : AppColors.black,
              size: 24.sp(context),
            ),
          ),
        ),
        SizedBox(width: 6.w(context)),
        Text(
          "${loveCount}k",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 11.sp(context),
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

// ANIMATION LOGIC

class _AnimatedLoveTooltip extends StatefulWidget {
  final VoidCallback onFinish;

  const _AnimatedLoveTooltip({required this.onFinish});

  @override
  State<_AnimatedLoveTooltip> createState() => _AnimatedLoveTooltipState();
}

class _AnimatedLoveTooltipState extends State<_AnimatedLoveTooltip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Total lifecycle
    );

    //  Pop In
    _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2, curve: Curves.elasticOut)),
    );

    // Fade Out
    _opacityAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.7, 1.0, curve: Curves.easeIn)),
    );

    // Float Up
    _slideAnim = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -20)).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.7, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward().whenComplete(widget.onFinish);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnim.value, // Moves up
          child: Opacity(
            opacity: _opacityAnim.value, // Fades out
            child: Transform.scale(
              scale: _scaleAnim.value, // Pops in
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w(context),
                    vertical: 6.h(context),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Love",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}