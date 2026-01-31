import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';

class EmptyUpdatesState extends StatelessWidget {
  const EmptyUpdatesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Placeholder
          Container(
            width: 150.w(context),
            height: 150.w(context),
            decoration: const BoxDecoration(
              color: Color(0xFFE2F0F9), // Light blue circle background
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.mail_solid,
              size: 70.sp(context),
              color: const Color(0xFF006699),
            ),
          ),
          SizedBox(height: 24.h(context)),

          Text(
            "Updates show activity on your Pins and boards and give you tips on topics to explore. They’ll be here soon.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14.sp(context),
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 100.h(context)),
        ],
      ),
    );
  }
}