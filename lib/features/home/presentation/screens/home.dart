import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/masonry_grid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomAppBar(context),

            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: MasonryGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      // Responsive padding
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 10.h(context),
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
                  fontSize: 16.sp(context), // Responsive Font Size
                  fontWeight: FontWeight.w600,
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
}