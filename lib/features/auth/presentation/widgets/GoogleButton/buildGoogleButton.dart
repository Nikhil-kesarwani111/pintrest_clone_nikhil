import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';


Widget buildGoogleButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 45.h(context),
    child: OutlinedButton(
      onPressed: () {
        context.pushNamed('clerkAuth');
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side:  BorderSide(color: Colors.grey.shade500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Google G Logo
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
            height: 20.h(context),
          ),
          SizedBox(width: 29.w(context)),
          Text(
            "Continue with Google",
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontSize: 16.sp(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
