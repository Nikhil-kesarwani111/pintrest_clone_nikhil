import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';

Widget buildFooterLegalText(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w(context)),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 11.sp(context),
          height: 1.4,
        ),
        children: [
          const TextSpan(text: "By continuing, you agree to Pinterest's "),

          TextSpan(
            text: "Terms of\nService",
            style: const TextStyle(
              color: AppColors.black,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),

          const TextSpan(text: " and acknowledge that you've read our\n"),

          TextSpan(
            text: "Privacy Policy",
            style: const TextStyle(
              color: AppColors.black,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),

          const TextSpan(text: ". "),


          TextSpan(
            text: "Notice at collection",
            style: const TextStyle(
              color: AppColors.black,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: "."),
        ],
      ),
    ),
  );
}