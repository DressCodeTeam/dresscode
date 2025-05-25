import 'package:dresscode/src/constants/api.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';

class GarmentsService {
  GarmentsService(this._apiClient);

  final ApiService _apiClient;

  Future<List<Garment>> getGarments() async {
    final response = await _apiClient.get(ApiConstants.findAllGarmentEndpoint);
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((garment) => Garment.fromJSON(garment as Map<String, dynamic>)).toList();
    } else {
      throw Exception(
          'Failed to load garments from API{${response.statusCode}}');
    }
  }

  Future<Garment> createGarment(Garment garment) async {
    final response = await _apiClient.post(ApiConstants.createGarmentEndpoint,
        data: garment.toJSON());
    final data = response.data as Map<String, dynamic>;

    return Garment.fromJSON(data);
  }
}
