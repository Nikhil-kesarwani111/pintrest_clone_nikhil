import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:pintrest_clone_nikhil/global/widgets/Pin_option_bottom_sheet/widgets/option_tile.dart';
import 'package:pintrest_clone_nikhil/global/widgets/Pin_option_bottom_sheet/widgets/report_tile.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../features/home/domain/entities/pin_entity.dart';

class PinOptionsBottomSheet extends StatelessWidget {
  final PinEntity pin;

  const PinOptionsBottomSheet({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    // Defines the layout proportions
    final double cardTopMargin = 125.h(context);
    final double imageWidth = 110.w(context);
    final double imageHeight = 200.h(context);

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [

        // --- Layer 1: Content Card ---
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: cardTopMargin),
          padding: EdgeInsets.fromLTRB(20.w(context), 20.h(context), 24.w(context), 40.h(context)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.w(context)),
              topRight: Radius.circular(35.w(context)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.close, size: 32.sp(context), color: AppColors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),

              SizedBox(height: 15.h(context)),

              // Header Text
              Center(
                child: Text(
                  "This Pin is inspired by your recent activity",
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp(context),
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(height: 20.h(context)),

              // Options Menu
              OptionTile(
                title: "Save",
                icon: CupertinoIcons.pin_fill,
                onTap: () => context.pop(),
              ),
              OptionTile(
                title: "Share",
                icon: Icons.share_outlined,
                onTap: () => context.pop(),
              ),
              OptionTile(
                title: "Download image",
                icon: Icons.download_outlined,
                onTap: () => context.pop(),
              ),
              OptionTile(
                title: "See more like this",
                icon: CupertinoIcons.heart,
                onTap: () => context.pop(),
              ),
              OptionTile(
                title: "See less like this",
                icon: CupertinoIcons.eye_slash,
                onTap: () => context.pop(),
              ),

              ReportTile(onTap: () => context.pop()),
            ],
          ),
        ),

        // --- Layer 2: Floating Image ---
        Positioned(
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.w(context)),
            child: CachedNetworkImage(
              imageUrl: pin.imageUrl,
              height: imageHeight,
              width: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}