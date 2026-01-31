import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../features/home/domain/entities/pin_entity.dart';
import '../widget/more_option_item.dart';

class MoreOptionsSheet extends StatelessWidget {
  final PinEntity pin;

  const MoreOptionsSheet({super.key, required this.pin});

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: pin.imageUrl));
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Link copied!", style: GoogleFonts.poppins())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.w(context)),
          topRight: Radius.circular(35.w(context)),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w(context),
        vertical: 20.h(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),

          SizedBox(height: 20.h(context)),

          MoreOptionItem(
            text: "Follow Tanúshree🎀",
            isBold: true,
            onTap: () => context.pop(),
          ),
          MoreOptionItem(
            text: "Share this Pin",
            onTap: () => context.pop(),
          ),
          MoreOptionItem(
            text: "Copy link",
            onTap: () => _copyLink(context),
          ),
          MoreOptionItem(
            text: "Download image",
            onTap: () => context.pop(),
          ),
          MoreOptionItem(
            text: "Hide Pin",
            onTap: () => context.pop(),
          ),
          MoreOptionItem(
            text: "Report Pin",
            onTap: () => context.pop(),
          ),

          SizedBox(height: 30.h(context)),

          _buildCloseButton(context),

          SizedBox(height: 20.h(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.close, size: 28.sp(context), color: AppColors.black),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        SizedBox(width: 20.w(context)),
        Text(
          "Options",
          style: GoogleFonts.poppins(
            fontSize: 18.sp(context),
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w(context),
            vertical: 12.h(context),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Close",
            style: GoogleFonts.poppins(
              fontSize: 16.sp(context),
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}