import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:pintrest_clone_nikhil/features/pin_DetailScreen/widgets/Pin_User_Info/widget/love_button.dart';
import 'package:pintrest_clone_nikhil/features/pin_DetailScreen/widgets/Pin_User_Info/widget/save_pin_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/domain/entities/pin_entity.dart';
import '../../Provider/pin_interaction_provider.dart';



class PinUserInfo extends ConsumerWidget {
  final PinEntity pin;

  const PinUserInfo({super.key, required this.pin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch specific state for this pin
    final pinState = ref.watch(pinInteractionProvider(pin.id));

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 16.h(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  Interactive Love Button
          LoveButton(
            pinId: pin.id,
            isLoved: pinState.isLoved,
            loveCount: pinState.loveCount,
          ),

          SizedBox(width: 20.w(context)),

          //  Standard Actions (Chat, Share, More)
          _buildIconAction(context, CupertinoIcons.chat_bubble),
          SizedBox(width: 20.w(context)),
          _buildIconAction(context, Icons.share_outlined),
          SizedBox(width: 20.w(context)),
          _buildIconAction(context, Icons.more_horiz),

          const Spacer(),

          //  Save/Profile Toggle
          SavePinButton(
            pinId: pin.id,
            isSaved: pinState.isSaved,
          ),
        ],
      ),
    );
  }

  Widget _buildIconAction(BuildContext context, IconData icon) {
    return Icon(
        icon,
        color: AppColors.black,
        size: 24.sp(context)
    );
  }
}