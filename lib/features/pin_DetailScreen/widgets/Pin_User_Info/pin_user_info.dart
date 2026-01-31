import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:pintrest_clone_nikhil/features/pin_DetailScreen/widgets/Pin_User_Info/widget/love_button.dart';
import 'package:pintrest_clone_nikhil/features/pin_DetailScreen/widgets/Pin_User_Info/widget/save_pin_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../global/widgets/more_options_sheet/Presentation/screen/more_options_sheet.dart';
import '../../../../global/widgets/share_bottom_sheet/Presentation/screen/share_bottom_sheet.dart';
import '../../../home/domain/entities/pin_entity.dart';
import '../../Provider/pin_interaction_provider.dart';

class PinUserInfo extends ConsumerWidget {
  final PinEntity pin;

  const PinUserInfo({super.key, required this.pin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinState = ref.watch(pinInteractionProvider(pin.id));

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 16.h(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoveButton(
            pinId: pin.id,
            isLoved: pinState.isLoved,
            loveCount: pinState.loveCount,
          ),

          SizedBox(width: 20.w(context)),

          _ActionButton(
            icon: CupertinoIcons.chat_bubble,
            onTap: () {
              // TODO: Implement chat feature
            },
          ),

          SizedBox(width: 20.w(context)),

          _ActionButton(
            icon: Icons.share_outlined,
            onTap: () => _showShareSheet(context),
          ),

          SizedBox(width: 20.w(context)),

          _ActionButton(
            icon: Icons.more_horiz,
            onTap: () => _showMoreOptions(context),
          ),

          const Spacer(),

          SavePinButton(
            pinId: pin.id,
            isSaved: pinState.isSaved,
          ),
        ],
      ),
    );
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ShareBottomSheet(pin: pin),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MoreOptionsSheet(pin: pin),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: AppColors.black,
        size: 24.sp(context),
      ),
    );
  }
}