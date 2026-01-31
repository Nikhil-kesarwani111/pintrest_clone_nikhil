import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/recent_search_entity.dart';

class RecentSearchTile extends StatelessWidget {
  final RecentSearchEntity item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RecentSearchTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.w(context),
            vertical: 8.h(context)
        ),
        child: Row(
          children: [
            //  Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.w(context)),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                height: 50.w(context),
                width: 50.w(context),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => Container(color: Colors.grey[300]),
              ),
            ),

            SizedBox(width: 16.w(context)),

            // Search Query Text
            Expanded(
              child: Text(
                item.query,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp(context),
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Delete Icon (X)
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.close,
                color: Colors.grey[500],
                size: 20.sp(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}