// router.dart
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pintrest_clone_nikhil/features/Navigation/Screens/main_screen.dart';
import 'package:pintrest_clone_nikhil/features/auth/presentation/screens/auth_screen.dart';
import 'package:pintrest_clone_nikhil/features/auth/presentation/screens/clerk_auth_screen.dart';

import '../../features/home/domain/entities/pin_entity.dart';
import '../../features/pin_DetailScreen/presentation/screens/pin_detail_screen.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final clerk = ClerkAuth.of(context);
    final isSignedIn = clerk.isSignedIn;
    final currentPath = state.matchedLocation;

    // If signed in and on auth pages, go to home
    if (isSignedIn && (currentPath == '/' || currentPath == '/clerkAuth')) {
      return '/home';
    }

    // If not signed in and trying to access home, go to root
    if (!isSignedIn && currentPath == '/home') {
      return '/';
    }
    // No redirect needed
    return null;
  },
  routes: [

    GoRoute(
      path: '/',
      name: 'landing',
      builder: (context, state) => const AuthScreen(),
    ),
   
    GoRoute(
      path: '/clerkAuth',
      name: 'clerkAuth',
      builder: (context, state) => const ClerkAuthScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/pin_detail',
      name: 'pin_detail',
      builder: (context, state) {
        final pin = state.extra as PinEntity;
        return PinDetailScreen(pin: pin);
      },
    ),

  ],
);