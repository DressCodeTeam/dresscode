import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/models/outfit.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:dresscode/src/services/outfits_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiClientProvider = Provider<ApiService>((ref) => ApiService(ref));

final outfitsServiceProvider = Provider<OutfitsService>(
  (ref) => OutfitsService(ref.read(apiClientProvider)),
);

final outfitsProvider = FutureProvider<List<Outfit>>((ref) async {
  final outfitsService = ref.watch(outfitsServiceProvider);
  return outfitsService.getOutfits();
});

final createOutfitProvider = FutureProvider.family<Outfit, Map<String, dynamic>>(
  (ref, data) async {
    final outfitsService = ref.watch(outfitsServiceProvider);
    return outfitsService.createOutfit(
      data['style'] as int,
      (data['garments'] as List<dynamic>).whereType<Garment>().toList(),
    );
  },
);

final outfitByIdProvider = FutureProvider.family<List<Garment>, int>(
  (ref, id) async {
    final outfitsService = ref.watch(outfitsServiceProvider);
    return outfitsService.getOutfitById(id);
  },
);