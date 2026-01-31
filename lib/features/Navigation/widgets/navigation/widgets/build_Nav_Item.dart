import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../create/presentation/widgets/create_bottom_sheet.dart';
import '../../../Provider/nav_provider.dart';

Widget buildNavItem(
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
      if (index == 2) {
        showModalBottomSheet(
          context: context,
          backgroundColor:
          Colors.transparent,
          isScrollControlled: true,
          builder: (context) => const CreateBottomSheet(),
        );
      } else {
        ref.read(navIndexProvider.notifier).state = index;
      }
    },
    behavior: HitTestBehavior.opaque,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          (index == 2)
              ? iconUnselected
              : (isSelected ? iconSelected : iconUnselected),
          color: AppColors.black,
          size: (isBoldWhenSelected && isSelected ? iconSize + 1 : iconSize)
              .sp(context),
        ),
        SizedBox(height: 4.h(context)),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.sp(context),
            fontWeight:
            (isSelected && index != 2)
                ? FontWeight.w600
                : FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    ),
  );
}