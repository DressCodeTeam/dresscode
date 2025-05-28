import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/models/outfit.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:dresscode/src/services/outfits_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiClientProvider = Provider<ApiService>((ref) => ApiService(ref));

final outfitsServiceProvider = Provider<OutfitsService>(
  (ref) {
    final apiClient = ref.watch(apiClientProvider);
    return OutfitsService(apiClient);
  });

final outfitsProvider = FutureProvider<List<Outfit>>((ref) {
  final outfitsService = ref.watch(outfitsServiceProvider);
  return outfitsService.getOutfits();
});

final createOutfitProvider = FutureProvider
  .family< Outfit, Map<String, dynamic> >(
  (ref, data) {
    final outfitsService = ref.watch(outfitsServiceProvider);
    return outfitsService.createOutfit(
      data['style'] as int,
      (data['garments'] as List<dynamic>).whereType<Garment>().toList(),
    );
  },
);

final outfitByIdProvider = FutureProvider.family<List<Garment>, int>(
  (ref, id) {
    final outfitsService = ref.watch(outfitsServiceProvider);
    return outfitsService.getOutfitById(id);
  },
);

final generateOutfitsProvider = FutureProvider.family<List<Outfit>, Map<String, dynamic>>(
  (ref, params) async {
    final outfitsService = ref.watch(outfitsServiceProvider);
    return await outfitsService.generateOutfits(
      nbOutfits: params['nb_outfits'] as int,
      styleId: params['style_id'] as int,
      weather: params['weather'] as String,
    );
  },
);
