import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../Provider/pin_interaction_provider.dart';

class SavePinButton extends ConsumerWidget {
  final int pinId;
  final bool isSaved;

  const SavePinButton({
    super.key,
    required this.pinId,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(pinInteractionProvider(pinId).notifier).toggleSave(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
            horizontal: 24.w(context),
            vertical: 14.h(context)
        ),
        decoration: BoxDecoration(
          color: isSaved ? const Color(0xFF333333) : AppColors.primary,
          borderRadius: BorderRadius.circular(18.w(context)),
        ),
        child: Text(
          isSaved ? "Saved" : "Save",
          style: GoogleFonts.poppins(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp(context),
          ),
        ),
      ),
    );
  }
}