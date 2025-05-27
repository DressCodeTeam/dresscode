import 'package:dresscode/src/models/category.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:dresscode/src/services/category_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiClientProvider = Provider<ApiService>((ref) => ApiService(ref));

final categorieServiceProvider = Provider<CategoryService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CategoryService(apiClient);
});

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final categoryService = ref.watch(categorieServiceProvider);
  return await categoryService.getCategories();
});

final selectedCategoryProvider = StateProvider<Category?>((ref) => null);
