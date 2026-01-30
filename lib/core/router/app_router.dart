// router.dart
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pintrest_clone_nikhil/features/auth/presentation/screens/auth_screen.dart';
import 'package:pintrest_clone_nikhil/features/auth/presentation/screens/clerk_auth_screen.dart';
import 'package:pintrest_clone_nikhil/features/home/presentation/screens/home.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final clerk = ClerkAuth.of(context);
    final isSignedIn = clerk.isSignedIn;

    final isGoingToLogin = state.matchedLocation == '/clerkAuth';
    final isGoingToHome = state.matchedLocation == '/home';
    final isGoingToRoot = state.matchedLocation == '/';

    // If not signed in and trying to access home, redirect to root
    if (!isSignedIn && isGoingToHome) {
      return '/';
    }

    // If signed in and on login page, redirect to home
    if (isSignedIn && isGoingToLogin) {
      return '/home';
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
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);