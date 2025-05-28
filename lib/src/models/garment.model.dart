import 'package:dresscode/src/models/base.model.dart';

class Garment extends BaseModel {
  Garment({
    required this.id,
    required this.imageUrl,
    required this.subcategory,
    required this.createdAt,
    this.description,
  });

  factory Garment.empty() {
    return Garment(
      id: -1,
      imageUrl: '',
      subcategory: '',
      createdAt: DateTime.now(),
    );
  }

  factory Garment.fromJSON(Map<String, dynamic> json) {
    return Garment(
      id: json['id'] as int? ?? -1,
      imageUrl: json['image_url']?.toString() ?? '',
      subcategory: json['subcategory']?.toString() ?? 'Inconnu',
      description: json['description']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  final int id;
  final String imageUrl;
  final String subcategory;
  final String? description;
  final DateTime createdAt;

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'image_url': imageUrl,
      'subcategory': subcategory,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
