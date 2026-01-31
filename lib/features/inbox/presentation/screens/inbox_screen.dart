import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            //Title Header (Inbox + Edit Icon)
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 14.w(context), vertical: 10.h(context)),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inbox",
                      style: GoogleFonts.poppins(
                        fontSize: 30.sp(context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit, // Looks closest to the edit icon
                        size: 24.sp(context),
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Messages Section Header
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w(context), vertical: 10.h(context)),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(
                      "Messages",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp(context),
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "See all",
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp(context),
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          Icon(Icons.chevron_right, size: 20.sp(context), color: AppColors.black),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // 3. "Invite your friends" Tile
            SliverToBoxAdapter(
              child: _InviteFriendsTile(),
            ),

            SliverSizedBox(height: 30.h(context)),

            // 4. Updates Section Header
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w(context)),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Updates",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp(context),
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),

            // 5. Empty State (Message in a Bottle)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: _EmptyUpdatesState(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS ---

class _InviteFriendsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w(context), vertical: 8.h(context)),
        child: Row(
          children: [
            // Circular Icon Button
            Container(
              width: 50.w(context),
              height: 50.w(context),
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9), // Light Grey
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_add_alt_1, // User with +
                color: AppColors.black,
                size: 26.sp(context),
              ),
            ),
            SizedBox(width: 16.w(context)),
            // Texts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Invite your friends",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp(context),
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  "Connect to start chatting",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp(context),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _EmptyUpdatesState extends StatelessWidget {
  const _EmptyUpdatesState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Placeholder
          // Since we don't have the exact asset, we use a styled Container/Icon
          // or a NetworkImage if you have one. Here is a custom shape logic.
          Container(
            width: 150.w(context),
            height: 150.w(context),
            decoration: const BoxDecoration(
              color: Color(0xFFE2F0F9), // Light blue circle background
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.mail_solid, // Fallback icon
              size: 70.sp(context),
              color: const Color(0xFF006699),
            ),
          ),
          SizedBox(height: 24.h(context)),
          Text(
            "Updates show activity on your Pins and boards and give you tips on topics to explore. They’ll be here soon.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14.sp(context),
              height: 1.5, // Line height for readability
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
          // Push content up slightly to match visual center
          SizedBox(height: 100.h(context)),
        ],
      ),
    );
  }
}

// A helper for Sliver spacing
class SliverSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  const SliverSizedBox({super.key, this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: height, width: width));
  }
}