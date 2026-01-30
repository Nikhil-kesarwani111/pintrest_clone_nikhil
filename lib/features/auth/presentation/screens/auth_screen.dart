import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart'; // Your provided extension
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/ AuthHeaderCollage/AuthHeaderCollage.dart';
import '../widgets/EmailField/buildTextField.dart';
import '../widgets/Footer/buildFooter.dart';
import '../widgets/GoogleButton/buildGoogleButton.dart';
import '../widgets/Red Button/buildRedButton.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = bottomInset > 0;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
        physics: isKeyboardOpen
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),

        child: SizedBox(
          height: context.height,

          child: Column(
            children: [
              // Top Animated Collage
              SizedBox(
                height: 326.h(context),
                width: double.infinity,
                child: const AuthHeaderCollage(),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w(context)),
                  child: Column(
                    children: [
                      SizedBox(height: 26.h(context)),

                      // Headline
                      Text(
                        "Create a life\nyou love",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 28.sp(context),
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                      ),

                      SizedBox(height: 28.h(context)),

                      // Email Input
                      buildTextField(context),

                      SizedBox(height: 26.h(context)),

                      // Continue Button
                      buildRedButton(context),

                      SizedBox(height: 26.h(context)),

                      // Google Button
                      buildGoogleButton(context),


                      SizedBox(height: 8.h(context)),
                      // Facebook Text
                      Text(
                        "Facebook login is no longer available.",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.sp(context),
                        ),
                      ),
                      SizedBox(height: 2.h(context)),
                      Text(
                        "Recover your account",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.sp(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 40.h(context)),

                      buildFooterLegalText(context),

                      SizedBox(height: 20.h(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}