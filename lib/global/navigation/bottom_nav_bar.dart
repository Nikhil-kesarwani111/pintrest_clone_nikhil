import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../core/constants/app_colors.dart';
import '../provider/nav_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);

    return BottomAppBar(
      color: AppColors.white,
      height: 65.h(context),
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w(context), vertical: 10.h(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. HOME
            _buildNavItem(
              context, ref,
              index: 0,
              label: "Home",
              iconSelected: CupertinoIcons.house_fill,
              iconUnselected: CupertinoIcons.house,
            ),

            // 2. SEARCH
            _buildNavItem(
              context, ref,
              index: 1,
              label: "Search",
              iconSelected: CupertinoIcons.search_circle_fill,
              iconUnselected: CupertinoIcons.search,
              isBoldWhenSelected: true,

            ),

            // 3. CREATE
            _buildNavItem(
              context, ref,
              index: 2,
              label: "Create",
              iconSelected: CupertinoIcons.add_circled_solid,
              iconUnselected: CupertinoIcons.add,
            ),

            // 4. INBOX
            _buildNavItem(
              context, ref,
              index: 3,
              label: "Inbox",
              iconSelected: CupertinoIcons.chat_bubble_text_fill,
              iconUnselected: CupertinoIcons.chat_bubble_text,
            ),

            // 5. SAVED / PROFILE
            _buildNavItem(
              context, ref,
              index: 4,
              label: "Saved",
              iconSelected: CupertinoIcons.person_fill,
              iconUnselected: CupertinoIcons.person,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context,
      WidgetRef ref, {
        required int index,
        required String label,
        required IconData iconSelected,
        required IconData iconUnselected,
        double iconSize = 22,
        bool isBoldWhenSelected = false,
      }) {
    final isSelected = ref.read(navIndexProvider) == index;

    return GestureDetector(
      onTap: () {
        // Update the provider to switch screens
        ref.read(navIndexProvider.notifier).state = index;
      },
      behavior: HitTestBehavior.opaque, // Makes touch area better
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? iconSelected : iconUnselected,
            // USER REQUIREMENT: All icons black
            color: AppColors.black,
            // If it's search, we might make it slightly larger/bolder manually if needed
            size: (isBoldWhenSelected && isSelected ? iconSize + 1 : iconSize).sp(context),
            // Optional: If you want unselected to be slightly lighter black (dark grey) for hierarchy:
            // color: isSelected ? AppColors.black : Colors.black54,
          ),
          SizedBox(height: 4.h(context)),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11.sp(context),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              // USER REQUIREMENT: Text also black
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}