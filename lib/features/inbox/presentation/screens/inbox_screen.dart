import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';

// Imports from the widgets folder
import '../widgets/empty_updates_state.dart';
import '../widgets/invite_friends_tile.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Title Header (Inbox + Edit Icon)
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w(context),
                  vertical: 10.h(context)
              ),
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
                        Icons.mode_edit_outline_outlined,
                        size: 28.sp(context),
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //  Messages Section Header
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w(context),
                  vertical: 10.h(context)
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(
                      "Messages",
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp(context),
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
                              fontSize: 13.sp(context),
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          Icon(
                              Icons.chevron_right,
                              size: 20.sp(context),
                              color: AppColors.black
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // 3. Invite Friends Tile
            const SliverToBoxAdapter(
              child: InviteFriendsTile(),
            ),

            // Spacer
            SliverToBoxAdapter(
              child: SizedBox(height: 30.h(context)),
            ),

            // 4. Updates Section Header
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w(context)),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Updates",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp(context),
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),

            // 5. Empty State (Fills remaining space)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyUpdatesState(),
            ),
          ],
        ),
      ),
    );
  }
}