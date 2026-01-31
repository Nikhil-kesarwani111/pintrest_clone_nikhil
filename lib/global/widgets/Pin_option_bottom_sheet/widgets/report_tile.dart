import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../../core/constants/app_colors.dart';

class ReportTile extends StatelessWidget {
  final VoidCallback onTap;

  const ReportTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.report_gmailerrorred, size: 20.sp(context), color: AppColors.black),
            SizedBox(width: 20.w(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Report Pin",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp(context),
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 4.h(context)),
                  Text(
                    "This goes against Pinterest's Community Guidelines",
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp(context),
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}