import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../home/domain/entities/pin_entity.dart';
import '../../home/presentation/widgets/pin_card.dart';

class RelatedPinsGrid extends StatelessWidget {
  final List<PinEntity> pins;

  const RelatedPinsGrid({super.key, required this.pins});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 4.w(context)),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h(context),
        crossAxisSpacing: 10.w(context),
        childCount: pins.length,
        itemBuilder: (context, index) {
          return PinCard(pin: pins[index]);
        },
      ),
    );
  }


// SnackBar(
// backgroundColor: Colors.black, // Use specific black if needed like Color(0xFF111111)
// duration: const Duration(milliseconds: 1000),
// behavior: SnackBarBehavior.floating,
//
// // 1. Reduce Height by removing default internal padding
// padding: EdgeInsets.symmetric(
// vertical: 6.h(context), // Controls the height (smaller value = slimmer bar)
// horizontal: 10.w(context), // Keep text from touching edges
// ),
//
// margin: EdgeInsets.only(
// bottom: 190.h(context),
// left: 17.w(context),
// // Adjust this if you need it wider/narrower
// right: context.width - 80.w(context),
// ),
//
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20.w(context)), // Increased radius looks better on slim bars
// ),
//
// content: Text(
// "Love",
// textAlign: TextAlign.center,
// style: GoogleFonts.poppins(
// color: AppColors.white,
// fontWeight: FontWeight.w600, // Slightly bolder is better for small text
// fontSize: 10.sp(context),   // 8.sp might be unreadable, 11-12 is usually safe
// ),
// ),
// );
}