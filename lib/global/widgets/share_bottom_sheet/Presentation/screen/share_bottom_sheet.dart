import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../features/home/domain/entities/pin_entity.dart';
import '../../widget/share_option_item.dart';

class ShareBottomSheet extends StatelessWidget {
  final PinEntity pin;

  const ShareBottomSheet({super.key, required this.pin});

  Future<void> _launchSocial(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) _systemShare();
    }
  }

  void _shareToWhatsApp(BuildContext context) {
    final text = "Check out this pin: ${pin.imageUrl}";
    _launchSocial(context, "whatsapp://send?text=${Uri.encodeComponent(text)}");
  }

  void _shareToTelegram(BuildContext context) {
    final text = "Check out this pin: ${pin.imageUrl}";
    _launchSocial(context, "tg://msg?text=${Uri.encodeComponent(text)}");
  }

  void _shareToGmail() async {
    final uri = Uri(
      scheme: 'mailto',
      query: 'subject=Check out this Pin&body=I found this on Pinterest: ${pin.imageUrl}',
    );
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: pin.imageUrl));
    context.pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Link copied to clipboard", style: GoogleFonts.poppins()),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.only(bottom: 50.h(context), left: 20, right: 20),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _systemShare() {
    Share.share('Check out this pin: ${pin.imageUrl}');
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h(context)),

          // Drag Handle
          Container(
            width: 40.w(context),
            height: 5.h(context),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w(context), vertical: 10.h(context)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.close, size: 28.sp(context), color: AppColors.black),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Share Pin link",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp(context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 48.w(context)),
              ],
            ),
          ),

          // Image Preview
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h(context)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.w(context)),
              child: CachedNetworkImage(
                imageUrl: pin.imageUrl,
                height: 220.h(context),
                width: 150.w(context),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15.h(context)),

          // Share Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
            child: Wrap(
              spacing: 24.w(context),
              runSpacing: 20.h(context),
              alignment: WrapAlignment.start,
              children: [
                ShareOptionItem(
                  label: "WhatsApp",
                  bgColor: const Color(0xFF25D366),
                  icon: Icons.chat_bubble,
                  onTap: () => _shareToWhatsApp(context),
                ),
                ShareOptionItem(
                  label: "Telegram",
                  bgColor: const Color(0xFF0088CC),
                  icon: Icons.send,
                  onTap: () => _shareToTelegram(context),
                ),
                ShareOptionItem(
                  label: "Copy link",
                  bgColor: Colors.grey[200]!,
                  icon: Icons.link,
                  iconColor: Colors.black,
                  onTap: () => _copyLink(context),
                ),
                ShareOptionItem(
                  label: "Gmail",
                  bgColor: const Color(0xFFEA4335),
                  icon: Icons.email,
                  onTap: _shareToGmail,
                ),
                ShareOptionItem(
                  label: "More",
                  bgColor: Colors.grey[200]!,
                  icon: Icons.more_horiz,
                  iconColor: Colors.black,
                  onTap: _systemShare,
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h(context)),
        ],
      ),
    );
  }
}