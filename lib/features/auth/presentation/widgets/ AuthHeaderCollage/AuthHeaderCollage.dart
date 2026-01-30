import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../../core/constants/app_assets.dart';
// Import the new extensions
import '../../../../../core/utils/responsiveness.dart';

class AuthHeaderCollage extends StatelessWidget {
  const AuthHeaderCollage({super.key});

  final List<String> _images = const [
    'https://images.pexels.com/photos/6758029/pexels-photo-6758029.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1468379/pexels-photo-1468379.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/7018389/pexels-photo-7018389.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  @override
  Widget build(BuildContext context) {
    // 1. USE .h(context) for clean scaling
    // On tablet, we might still want a specific override, or just let it scale.
    // Here we scale the 258 design height to the current screen.
    final double containerHeight = context.isTablet ? 360 : 258.h(context);

    return SizedBox(
      height: containerHeight,
      child: Stack(
        children: [
          // Grid
          MasonryGridView.count(
            physics: const NeverScrollableScrollPhysics(),
            // Responsive Column Count
            crossAxisCount: context.isTablet ? 4 : 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: 4,
            itemBuilder: (context, index) {
              return ClipRRect(
                // Scale the radius too!
                borderRadius: BorderRadius.circular(12.w(context)),
                child: Image.network(
                  _images[index],
                  fit: BoxFit.cover,
                  // Scale image heights dynamically
                  height: index == 1
                      ? (context.isTablet ? 350 : 280.h(context))
                      : (context.isTablet ? 220 : 160.h(context)),
                ),
              );
            },
          ),



          // Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: containerHeight * 0.9,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.8),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),

          Center(
            child: Container(
              // Scale the logo size
              height: 72.w(context),
              width: 72.w(context),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.15),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(12.w(context)), // Scale padding
                child: Image.asset(
                  AppAssets.appIcon,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}