import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:dresscode/src/services/garments_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiService>((ref) => ApiService());

final garmentServiceProvider = Provider<GarmentsService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GarmentsService(apiClient);
});

final garmentsProvider = FutureProvider<List<Garment>>((ref) {
  final garmentService = ref.watch(garmentServiceProvider);
  return garmentService.getGarments();
});
