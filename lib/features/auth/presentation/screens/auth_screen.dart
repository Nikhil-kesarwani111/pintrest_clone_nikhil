import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';

import '../widgets/ AuthHeaderCollage/AuthHeaderCollage.dart'; // Check path

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      // 2. Allow the Scaffold to resize so the keyboard pushes content up
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Column(
          children: [
            if (!isKeyboardOpen)
              SizedBox(child: const AuthHeaderCollage(), height: 300.h(context)),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () {
                    context.goNamed('clerkAuth');
                  },
                  child: const Text(
                    'Sign in with email',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}