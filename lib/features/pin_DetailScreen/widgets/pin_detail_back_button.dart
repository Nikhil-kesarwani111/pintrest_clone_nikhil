import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';

class PinDetailBackButton extends StatelessWidget {
  const PinDetailBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 9.h(context),
      left: 9.w(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.60),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22.sp(context),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}