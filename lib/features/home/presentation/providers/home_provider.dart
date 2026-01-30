import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/dataSource/home_api_source.dart';
import '../../data/repositories/home_repo_impl.dart';
import '../../domain/ repositories/home_repo.dart';
import '../../domain/entities/pin_entity.dart';

// 1. DIO PROVIDER
final dioProvider = Provider<DioClient>((ref) {
  return DioClient();
});

// 2. REPOSITORY PROVIDER
final homeRepoProvider = Provider<HomeRepo>((ref) {
  final dioClient = ref.read(dioProvider);
  final apiSource = HomeApiSource(dioClient);
  return HomeRepoImpl(apiSource);
});

// --- STATE CLASS ---
class HomeState {
  final List<PinEntity> pins;
  final bool isLoading;
  final String? errorMessage;
  final int currentPage;

  const HomeState({
    this.pins = const [],
    this.isLoading = false,
    this.errorMessage,
    this.currentPage = 1,
  });

  HomeState copyWith({
    List<PinEntity>? pins,
    bool? isLoading,
    String? errorMessage,
    int? currentPage,
  }) {
    return HomeState(
      pins: pins ?? this.pins,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

// 3. CONTROLLER PROVIDER
final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  final repo = ref.read(homeRepoProvider);
  return HomeController(repo);
});

class HomeController extends StateNotifier<HomeState> {
  final HomeRepo _repo;

  HomeController(this._repo) : super(const HomeState()) {
    loadPins();
  }

  Future<void> loadPins({bool refresh = false}) async {
    if (refresh) {
      state = const HomeState();
    }

    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final newPins = await _repo.getCuratedPins(page: state.currentPage);

      state = state.copyWith(
        isLoading: false,
        pins: [...state.pins, ...newPins],
        currentPage: state.currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}