import 'package:dresscode/src/models/outfit.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:dresscode/src/constants/api.dart';

class OutfitsService {
  OutfitsService(this._apiClient);
  final ApiService _apiClient;

  // Récupérer tous les outfits
  Future<List<Outfit>> getOutfits() async {
    final response = await _apiClient.get(ApiConstants.findAllOutfitsEndpoint);
    final data = response.data as List<dynamic>;

    return data
        .map((outfit) => Outfit.fromJSON(outfit as Map<String, dynamic>))
        .toList();
  }

  // Créer un nouvel outfit
  Future<Outfit> createOutfit(Outfit outfit) async {
    final response = await _apiClient.post(
      ApiConstants.createOutfitEndpoint,
      data: outfit.toJSON(),
    );
    final data = response.data as Map<String, dynamic>;

    return Outfit.fromJSON(data);
  }

  // Récupérer un outfit par ID
  Future<Outfit> getOutfitById(String id) async {
    final response =
        await _apiClient.get('${ApiConstants.findOutfitByIdEndpoint}/$id');
    final data = response.data as Map<String, dynamic>;

    return Outfit.fromJSON(data);
  }

  // Supprimer un outfit par ID
  Future<void> deleteOutfit(String id) async {
    await _apiClient.delete('${ApiConstants.findOutfitByIdEndpoint}/$id');
  }
}
