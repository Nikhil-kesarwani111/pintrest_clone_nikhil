import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';

import '../../../../../../core/constants/app_assets.dart';

class PintrestLogo extends StatelessWidget {
  const PintrestLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 280.h(context),
      child: Image.asset(
        AppAssets.appIcon,
        height: 34.w(context),
        width: 34.w(context),
      ),
    );
  }
}
