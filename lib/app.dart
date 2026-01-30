import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/router/app_router.dart';
import 'core/constants/app_colors.dart';

class PinterestCloneApp extends StatelessWidget{
  const PinterestCloneApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Pinterest Clone',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.black),
          titleTextStyle: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

    );
  }
}