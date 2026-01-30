import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';

import '../../../../core/constants/app_colors.dart';


Widget buildCustomAppBar(BuildContext context) {
  return Padding(
    // Responsive padding
    padding: EdgeInsets.symmetric(
      horizontal: 16.w(context),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // "For You" Section
        Column(
          children: [
            Text(
              "For you",
              style: GoogleFonts.poppins( // Changed to Poppins
                fontSize: 15.sp(context), // Responsive Font Size
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h(context)), // Responsive spacing

            // The Black Underline Indicator
            Container(
              height: 3.h(context),
              width: 45.w(context), // Responsive width
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),

        // Settings / Logout Icon
        IconButton(
          icon: Icon(
            Icons.logout,
            color: AppColors.grey,
            size: 24.sp(context), // Responsive Icon Size
          ),
          onPressed: () async {
            await ClerkAuth.of(context).signOut();
          },
        )
      ],
    ),
  );
}
