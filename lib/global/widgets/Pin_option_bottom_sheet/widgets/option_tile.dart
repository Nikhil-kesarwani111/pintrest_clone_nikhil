import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../../core/constants/app_colors.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h(context)),
        child: Row(
          children: [
            Icon(icon, size: 20.sp(context), color: AppColors.black),
            SizedBox(width: 20.w(context)),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20.sp(context),
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}