import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/providers/categories_provider.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:dresscode/src/services/garments_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiService>((ref) => ApiService(ref));

final garmentServiceProvider = Provider<GarmentsService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GarmentsService(apiClient);
});

final garmentsProvider = FutureProvider<List<Garment>>((ref) async {
  final garmentService = ref.watch(garmentServiceProvider);
  return await garmentService.getGarments();
});

final filteredGarmentsProvider = Provider<AsyncValue<List<Garment>>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final garmentsAsync = ref.watch(garmentsProvider);

  if (selectedCategory == null) {
    return garmentsAsync;
  }

  return garmentsAsync.when(
    data: (garments) {
      // Noms de toutes les sous-catégories de la catégorie sélectionnée
      final subcategoryNames = selectedCategory.subcategories
          .map((sc) => sc.name)
          .toSet();

      // Filtrer les vêtements
      final filteredGarments = garments
          .where((garment) => subcategoryNames.contains(garment.subcategory))
          .toList();

      return AsyncValue.data(filteredGarments);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});
