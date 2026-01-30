import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:pintrest_clone_nikhil/features/auth/presentation/widgets/%20AuthHeaderCollage/widgets/SmoothAnimatedItem.dart';
import 'package:pintrest_clone_nikhil/features/auth/presentation/widgets/%20AuthHeaderCollage/widgets/logo.dart';

import '../../../../../core/constants/app_assets.dart';

class AuthHeaderCollage extends StatefulWidget {
  const AuthHeaderCollage({super.key});

  @override
  State<AuthHeaderCollage> createState() => _AuthHeaderCollageState();
}

class _AuthHeaderCollageState extends State<AuthHeaderCollage> with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _entranceFade;
  late Animation<double> _entranceScale;

  late AnimationController _breathingController;

  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _entranceFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _entranceScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _entranceController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.repeat(reverse: true);
      }
    });

    Animation<Offset> createSlide(Offset begin, double startTime) {
      return Tween<Offset>(begin: begin, end: Offset.zero).animate(
        CurvedAnimation(
          parent: _entranceController,
          curve: Interval(startTime, 1.0, curve: Curves.easeOutQuart),
        ),
      );
    }

    _slideAnimations = [
      //  Top Left (From Left)
      createSlide(const Offset(-1.5, 0.2), 0.0),
      //  Center (From Bottom)
      createSlide(const Offset(0.0, 0.8), 0.1),
      //  Top Right (From Right)
      createSlide(const Offset(1.5, 0.2), 0.0),
      //  Bottom Left (From Left)
      createSlide(const Offset(-1.2, 0.5), 0.2),
      //  Bottom Right (From Right)
      createSlide(const Offset(1.2, 0.5), 0.2),
    ];

    // Start
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RepaintBoundary(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // 1. TOP LEFT
            Positioned(
              top: -20,
              left: -10,
              child: SmoothAnimatedItem(
                slideAnim: _slideAnimations[0],
                fadeAnim: _entranceFade,
                scaleAnim: _entranceScale,
                breathingController: _breathingController,
                randomOffset: 0.0,
                scaleRange: 0.03,
                verticalDistance: 5.0,
                url: "https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=300",
                width: 80.w(context),
                height: 80.h(context),
              ),
            ),

            // 2. CENTER
            Positioned(
              top: 40.h(context),
              child: SmoothAnimatedItem(
                slideAnim: _slideAnimations[1],
                fadeAnim: _entranceFade,
                scaleAnim: _entranceScale,
                breathingController: _breathingController,
                randomOffset: 2.0,
                scaleRange: 0.03,
                verticalDistance: 0.0,
                url: "https://images.pexels.com/photos/1926769/pexels-photo-1926769.jpeg?auto=compress&cs=tinysrgb&w=300",
                width: 150.w(context),
                height: 220.h(context),
              ),
            ),

            // LOGO IMAGE
             PintrestLogo(),

            // TOP RIGHT
            Positioned(
              top: 30.h(context),
              right: -30,
              child: SmoothAnimatedItem(
                slideAnim: _slideAnimations[2],
                fadeAnim: _entranceFade,
                scaleAnim: _entranceScale,
                breathingController: _breathingController,
                randomOffset: 1.0,
                scaleRange: 0.03,
                verticalDistance: 4.0,
                url: "https://images.pexels.com/photos/3762466/pexels-photo-3762466.jpeg?auto=compress&cs=tinysrgb&w=300",
                width: 110.w(context),
                height: 120.h(context),
              ),
            ),

            // BOTTOM LEFT
            Positioned(
              top: 140.h(context),
              left: -90,
              child: SmoothAnimatedItem(
                slideAnim: _slideAnimations[3],
                fadeAnim: _entranceFade,
                scaleAnim: _entranceScale,
                breathingController: _breathingController,
                randomOffset: 3.5,
                scaleRange: 0.03,
                verticalDistance: 6.0,
                url: "https://images.pexels.com/photos/887853/pexels-photo-887853.jpeg?auto=compress&cs=tinysrgb&w=300",
                width: 170.w(context),
                height: 170.h(context),
              ),
            ),

            // BOTTOM RIGHT
            Positioned(
              top: 210.h(context),
              right: -60,
              child: SmoothAnimatedItem(
                slideAnim: _slideAnimations[4],
                fadeAnim: _entranceFade,
                scaleAnim: _entranceScale,
                breathingController: _breathingController,
                randomOffset: 3.0,
                scaleRange: 0.03,
                verticalDistance: 2.0,
                url: "https://images.pexels.com/photos/6707628/pexels-photo-6707628.jpeg?auto=compress&cs=tinysrgb&w=300",
                width: 150.w(context),
                height: 100.h(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

