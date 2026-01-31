import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';

class ShareOptionItem extends StatelessWidget {
  final String label;
  final Color bgColor;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const ShareOptionItem({
    super.key,
    required this.label,
    required this.bgColor,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w(context),
            height: 60.w(context),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28.sp(context),
            ),
          ),
          SizedBox(height: 8.h(context)),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.sp(context),
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}