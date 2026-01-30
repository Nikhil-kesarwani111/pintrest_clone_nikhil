import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';


Widget buildRedButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 37.h(context),
    child: ElevatedButton(
      onPressed: () {
        context.pushNamed('clerkAuth');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        "Continue",
        style: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 16.sp(context),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
