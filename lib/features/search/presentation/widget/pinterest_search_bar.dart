import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';

class PinterestSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onCameraTap;
  final VoidCallback? onClearTap;
  final bool hideTrailingIcon;

  const PinterestSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.onCameraTap,
    this.onClearTap,
    this.hideTrailingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFocus = focusNode.hasFocus;
    final bool hasText = controller.text.isNotEmpty;

    return Container(
      height: 48.h(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w(context)),
        border: Border.all(color: Colors.grey.shade800, width: 0.9),
      ),
      padding: EdgeInsets.only(left: 16.w(context), right: 12.w(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search Icon
          if (!hasFocus && !hideTrailingIcon) ...[
            Icon(
              CupertinoIcons.search,
              color: Colors.grey[600],
              size: 24.sp(context),
            ),
            SizedBox(width: 12.w(context)),
          ],

          //  Text Field
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              style: GoogleFonts.poppins(
                fontSize: 16.sp(context),
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: "Search for ideas",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16.sp(context),
                  color: Colors.grey[600],
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),

              textAlignVertical: TextAlignVertical.center,
            ),
          ),

          // Right Icon
          if (!hideTrailingIcon) ...[
            if (hasText)
              GestureDetector(
                onTap: onClearTap,
                child: Icon(
                  CupertinoIcons.clear_circled_solid,
                  color: Colors.grey[600],
                  size: 20.sp(context),
                ),
              )
            else
              GestureDetector(
                onTap: onCameraTap,
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColors.black,
                  size: 26.sp(context),
                ),
              ),
          ]
        ],
      ),
    );
  }
}