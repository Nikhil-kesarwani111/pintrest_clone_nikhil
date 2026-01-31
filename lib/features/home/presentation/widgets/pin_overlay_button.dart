import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';

class PinOverlayButton extends StatefulWidget {
  const PinOverlayButton({super.key});

  @override
  State<PinOverlayButton> createState() => _PinOverlayButtonState();
}

class _PinOverlayButtonState extends State<PinOverlayButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: _isExpanded ? 12.w(context) : 8.w(context),
          vertical: 6.h(context),
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          // Responsive Radius
          borderRadius: BorderRadius.circular(20.w(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isExpanded) ...[
              Text(
                "Profile",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp(context),
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 4.w(context)),
              Icon(
                CupertinoIcons.chevron_right,
                color: AppColors.white,
                size: 14.sp(context),
              ),
            ] else
              Icon(
                CupertinoIcons.pin_fill,
                color: AppColors.white,
                size: 16.sp(context),
              ),
          ],
        ),
      ),
    );
  }
}