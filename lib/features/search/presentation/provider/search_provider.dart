import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/recent_search_entity.dart';

class RecentSearchNotifier extends StateNotifier<List<RecentSearchEntity>> {
  RecentSearchNotifier() : super([]);

  void loadMockData() {
    state = [
      RecentSearchEntity(
        id: '1',
        query: 'anime drawing',
        imageUrl: 'https://images.pexels.com/photos/1762851/pexels-photo-1762851.jpeg?auto=compress&cs=tinysrgb&w=200', // Mock Image
      ),
      RecentSearchEntity(
        id: '2',
        query: 'nikhila vimal saree',
        imageUrl: 'https://images.pexels.com/photos/104827/cat-pet-animal-domestic-104827.jpeg?auto=compress&cs=tinysrgb&w=200', // Mock Image
      ),
      RecentSearchEntity(
        id: '3',
        query: 'bjn',
        imageUrl: 'https://images.pexels.com/photos/19619176/pexels-photo-19619176/free-photo-of-woman-in-sari.jpeg?auto=compress&cs=tinysrgb&w=200', // Mock Image
      ),
    ];
  }

  void removeSearch(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void addSearch(String query, String imageUrl) {
    final newItem = RecentSearchEntity(
      id: DateTime.now().toString(),
      query: query,
      imageUrl: imageUrl,
    );
    // Add to top and avoid duplicates
    state = [newItem, ...state.where((item) => item.query != query)];
  }
}

// The global provider to use in the widgets
final recentSearchProvider = StateNotifierProvider<RecentSearchNotifier, List<RecentSearchEntity>>((ref) {
  final notifier = RecentSearchNotifier();
  notifier.loadMockData(); // Initialize with data
  return notifier;
});