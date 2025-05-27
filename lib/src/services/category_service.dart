import 'package:dresscode/src/constants/api.dart';
import 'package:dresscode/src/models/category.model.dart';
import 'package:dresscode/src/services/api/api_service.dart';
import 'package:flutter/material.dart';

class CategoryService {
  CategoryService(this._apiClient);

  final ApiService _apiClient;

  Future<List<Category>> getCategories() async {
    final response = await _apiClient.get(ApiConstants.categoriesEndpoint);
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map(
        (category) => Category.fromJSON(
          category as Map<String, dynamic>
        )
      ).toList();
    } else {
      throw Exception(
        'Failed to load categories from API{${response.statusCode}}');
    }
  }
}
