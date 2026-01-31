import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/radial_bubble.dart';

class PinterestLongPressMenu extends StatefulWidget {
  final Widget child;
  final String imageUrl;
  final VoidCallback onSave;
  final VoidCallback onSearch;
  final VoidCallback onShare;
  final VoidCallback onWhatsApp;

  const PinterestLongPressMenu({
    super.key,
    required this.child,
    required this.imageUrl,
    required this.onSave,
    required this.onSearch,
    required this.onShare,
    required this.onWhatsApp,
  });

  @override
  State<PinterestLongPressMenu> createState() => _PinterestLongPressMenuState();
}

class _PinterestLongPressMenuState extends State<PinterestLongPressMenu> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // State
  int _selectedIndex = -1;
  Offset _menuCenter = Offset.zero;
  Rect? _childRect;

  // Constants
  static const double _menuRadius = 70.0;
  static const double _bubbleSize = 50.0;
  static const double _deadZone = 20.0; // Movement required to trigger selection

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Overlay Management

  void _showOverlay(BuildContext context, Offset touchPosition) {
    HapticFeedback.selectionClick();
    _selectedIndex = -1;

    // 1. Capture original widget position for spotlight effect
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    _childRect = offset & renderBox.size;

    // 2. Clamp menu position to keep bubbles on screen
    final size = MediaQuery.sizeOf(context);
    final double padding = _menuRadius + _bubbleSize;

    _menuCenter = Offset(
      touchPosition.dx.clamp(padding, size.width - padding),
      touchPosition.dy.clamp(padding + 50, size.height - padding),
    );

    _overlayEntry = OverlayEntry(builder: (context) => _buildOverlayContent(context));
    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
  }

  void _hideOverlay() {
    _controller.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  //  Selection Logic

  void _updateSelection(Offset touchPosition) {
    final double dx = touchPosition.dx - _menuCenter.dx;
    final double dy = touchPosition.dy - _menuCenter.dy;
    final double distance = sqrt(dx * dx + dy * dy);

    int newIndex = -1;

    if (distance > _deadZone) {
      double angle = atan2(dy, dx) * 180 / pi;
      if (angle < 0) angle += 360;

      // Map angles to indexes
      if (angle >= 330 || angle <= 30) newIndex = 3;       // Right (0°)
      else if (angle >= 30 && angle <= 90) newIndex = 2;   // Top Right (60°)
      else if (angle >= 90 && angle <= 150) newIndex = 1;  // Top Left (120°)
      else if (angle >= 150 && angle <= 210) newIndex = 0; // Left (180°)
    }

    if (newIndex != _selectedIndex) {
      if (newIndex != -1) HapticFeedback.selectionClick();
      _overlayEntry?.markNeedsBuild();
      _selectedIndex = newIndex;
    }
  }

  void _triggerAction() {
    switch (_selectedIndex) {
      case 0: widget.onSave(); break;
      case 1: widget.onShare(); break;
      case 2: widget.onSearch(); break;
      case 3: widget.onWhatsApp(); break;
    }
    _hideOverlay();
  }

  String _getLabel() {
    switch (_selectedIndex) {
      case 0: return "Save";
      case 1: return "Share";
      case 2: return "Search image";
      case 3: return "WhatsApp";
      default: return "";
    }
  }

  //  UI Builders

  Widget _buildOverlayContent(BuildContext context) {
    return Stack(
      children: [
        // 1. Dimmed Background
        Positioned.fill(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 200),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (_, value, __) => Container(color: Colors.white.withOpacity(0.9 * value)),
          ),
        ),

        // 2. Spotlight Image
        if (_childRect != null)
          Positioned.fromRect(
            rect: _childRect!,
            child: Transform.scale(
              scale: 1.02,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: Colors.grey[200]),
                ),
              ),
            ),
          ),

        // 3. Radial Menu
        Positioned(
          left: _menuCenter.dx,
          top: _menuCenter.dy,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) => Stack(
              clipBehavior: Clip.none,
              children: [
                _buildOption(0, Icons.push_pin, 180),
                _buildOption(1, Icons.share, 120),
                _buildOption(2, Icons.center_focus_strong, 60),
                _buildOption(3, Icons.chat_bubble, 0),
              ],
            ),
          ),
        ),

        // 4. Label
        if (_selectedIndex != -1)
          Positioned(
            top: _menuCenter.dy - 130,
            left: 0,
            right: 0,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  _getLabel(),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOption(int index, IconData icon, double angle) {
    return RadialBubble(
      icon: icon,
      isSelected: _selectedIndex == index,
      angleDegrees: angle,
      radius: _menuRadius,
      bubbleSize: _bubbleSize,
      scaleAnimation: _scaleAnimation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) => _showOverlay(context, details.globalPosition),
      onLongPressMoveUpdate: (details) => _updateSelection(details.globalPosition),
      onLongPressEnd: (_) => _triggerAction(),
      child: widget.child,
    );
  }
}