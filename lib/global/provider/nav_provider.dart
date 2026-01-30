import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stores the current index of the bottom nav (0 = Home, 1 = Search, etc.)
final navIndexProvider = StateProvider<int>((ref) => 0);