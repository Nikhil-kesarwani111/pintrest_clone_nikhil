import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart'; // Ensure this matches your file path
import '../../../../core/constants/app_colors.dart';

class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35.w(context)),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w(context),
        vertical: 20.h(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                    Icons.close,
                    size: 28.sp(context),
                    color: AppColors.black
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

              Center(
                child: Text(
                  "Start creating now",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp(context),
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30.h(context)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(context, icon: CupertinoIcons.pin_fill, label: "Pin"),
              _buildOption(context, icon: CupertinoIcons.scissors, label: "Collage"),
              _buildOption(context, icon: CupertinoIcons.square_grid_2x2_fill, label: "Board"),
            ],
          ),

          SizedBox(height: 40.h(context)), // Bottom Safe Area Spacing
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, {required IconData icon, required String label}) {
    return Column(
      children: [
        Container(
          // FIX: Use .w(context) for BOTH to keep it a perfect square based on screen width
          height: 65.w(context),
          width: 65.w(context),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(22.w(context)),
          ),
          child: Icon(
            icon,
            size: 30.sp(context),
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h(context)),
        // Label Text
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.sp(context),
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}