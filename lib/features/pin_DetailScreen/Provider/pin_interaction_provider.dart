import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. THE STATE MODEL
class PinState {
  final bool isLoved;
  final bool isSaved;
  final int loveCount;

  PinState({
    this.isLoved = false,
    this.isSaved = false,
    this.loveCount = 15, // Default starting count (15k)
  });

  // Helper to copy state efficiently
  PinState copyWith({bool? isLoved, bool? isSaved, int? loveCount}) {
    return PinState(
      isLoved: isLoved ?? this.isLoved,
      isSaved: isSaved ?? this.isSaved,
      loveCount: loveCount ?? this.loveCount,
    );
  }
}

// 2. THE NOTIFIER (LOGIC)
class PinInteractionNotifier extends FamilyNotifier<PinState, int> {
  // We use the pin's ID (int) as the family unique key

  @override
  PinState build(int arg) {
    // Initial State: You could fetch real API data here if needed
    return PinState(isLoved: false, isSaved: false, loveCount: 15);
  }

  void toggleLove() {
    final isCurrentlyLoved = state.isLoved;
    // Update state: Toggle boolean and adjust count
    state = state.copyWith(
      isLoved: !isCurrentlyLoved,
      loveCount: isCurrentlyLoved ? state.loveCount - 1 : state.loveCount + 1,
    );
  }

  void toggleSave() {
    state = state.copyWith(isSaved: !state.isSaved);
  }
}

// 3. THE PROVIDER DEFINITION
// We use .family to create a unique provider for EVERY unique Pin ID
final pinInteractionProvider = NotifierProvider.family<PinInteractionNotifier, PinState, int>(
      () => PinInteractionNotifier(),
);