/// Clerk Auth Screeen

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../global/widgets/rotating_dots_indicator.dart';


class ClerkAuthScreen extends StatelessWidget {
  const ClerkAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: ClerkAuthBuilder(
            signedInBuilder: (context, authState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.go('/home');
                }
              });
              return Center(
                child: RotatingFourDots(
                  dotColor: AppColors.primary,
              ),
              );
            },
            signedOutBuilder: (context, authState) {
              return Column(
                children: [
                  Expanded(child: const ClerkAuthentication()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}