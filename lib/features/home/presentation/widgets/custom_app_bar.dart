import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';

import '../../../../core/constants/app_colors.dart';


Widget buildCustomAppBar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 16.w(context),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "For you",
              style: GoogleFonts.poppins(
                fontSize: 15.sp(context),
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h(context)),
            Container(
              height: 3.h(context),
              width: 45.w(context),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),

        IconButton(
          icon: Icon(
            Icons.logout,
            color: AppColors.grey,
            size: 24.sp(context),
          ),
          onPressed: () async {
            await ClerkAuth.of(context).signOut();
          },
        )
      ],
    ),
  );
}
