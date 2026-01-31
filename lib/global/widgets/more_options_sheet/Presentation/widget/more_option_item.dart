import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../../core/constants/app_colors.dart';

class MoreOptionItem extends StatelessWidget {
  final String text;
  final bool isBold;
  final VoidCallback onTap;

  const MoreOptionItem({
    super.key,
    required this.text,
    required this.onTap,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h(context)),
        child: Row(
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 18.sp(context),
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}