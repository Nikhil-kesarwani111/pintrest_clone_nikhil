import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';

class InviteFriendsTile extends StatelessWidget {
  const InviteFriendsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Handle invite action
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w(context), vertical: 8.h(context)),
        child: Row(
          children: [
            Container(
              width: 50.w(context),
              height: 50.w(context),
              decoration: const BoxDecoration(
                color: Color(0xFFE9E9E9),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Icon(
                Icons.person_add_alt_1,
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