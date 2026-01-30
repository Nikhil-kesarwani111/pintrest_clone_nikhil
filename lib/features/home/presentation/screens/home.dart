import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          // Option 1: Logout Icon in the AppBar
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ClerkAuth.of(context).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You are now signed in!"),
            const SizedBox(height: 20),
            // Option 2: Big Logout Button in the center
            ElevatedButton(
              onPressed: () async {
                await ClerkAuth.of(context).signOut();
              },
              child: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}