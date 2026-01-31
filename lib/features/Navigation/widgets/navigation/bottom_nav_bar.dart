import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // REQUIRED
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../../Provider/nav_provider.dart';
import 'package:pintrest_clone_nikhil/features/create/presentation/widgets/create_bottom_sheet.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);

    return Container(
      height: 68.h(context),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w(context), vertical: 10.h(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, ref, index: 0, label: "Home", iconSelected: CupertinoIcons.house_fill, iconUnselected: CupertinoIcons.house),
          _buildNavItem(context, ref, index: 1, label: "Search", iconSelected: CupertinoIcons.search_circle_fill, iconUnselected: CupertinoIcons.search, isBoldWhenSelected: true),
          _buildNavItem(context, ref, index: 2, label: "Create", iconSelected: CupertinoIcons.add, iconUnselected: CupertinoIcons.add),
          _buildNavItem(context, ref, index: 3, label: "Inbox", iconSelected: CupertinoIcons.chat_bubble_text_fill, iconUnselected: CupertinoIcons.chat_bubble_text),
          _buildNavItem(context, ref, index: 4, label: "Saved", iconSelected: CupertinoIcons.person_fill, iconUnselected: CupertinoIcons.person),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, WidgetRef ref, {required int index, required String label, required IconData iconSelected, required IconData iconUnselected, bool isBoldWhenSelected = false}) {
    final isSelected = ref.watch(navIndexProvider) == index;

    return GestureDetector(
      onTap: () {
        if (index == 2) {
          // --- CASE 1: CREATE BUTTON (Show Sheet, Stay on Screen) ---
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => const CreateBottomSheet(),
          );
        } else {
          // --- CASE 2: NAVIGATION BUTTONS (Home, Search, Inbox, Saved) ---

          ref.read(navIndexProvider.notifier).state = index;

          context.go('/home');
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon((index == 2) ? iconUnselected : (isSelected ? iconSelected : iconUnselected), color: AppColors.black, size: (isBoldWhenSelected && isSelected ? 26 : 24).sp(context)),
          SizedBox(height: 4.h(context)),
          Text(label, style: GoogleFonts.poppins(fontSize: 11.sp(context), fontWeight: (isSelected && index != 2) ? FontWeight.w600 : FontWeight.w500, color: AppColors.black)),
        ],
      ),
    );
  }
}