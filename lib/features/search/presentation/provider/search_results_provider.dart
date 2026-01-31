import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../home/domain/entities/pin_entity.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepositoryImpl(DioClient());
});

final searchResultsProvider = FutureProvider.family<List<PinEntity>, String>((ref, query) async {
  final repository = ref.watch(searchRepositoryProvider);

  final result = await repository.searchPins(query);

  return result.fold(
        (failure) => throw failure.message,
        (pins) => pins, // Return the list of pins
  );
});