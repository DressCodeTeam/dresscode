import 'package:dresscode/src/models/base.model.dart';

class Garment extends BaseModel {
  Garment({
    required this.id,
    required this.imageUrl,
    required this.subcategory,
    this.description,
    required this.createdAt,
  });

  factory Garment.empty() {
    return Garment(
      id: -1,
      imageUrl: '',
      subcategory: '',
      description: null,
      createdAt: DateTime.now(),
    );
  }

  factory Garment.fromJSON(Map<String, dynamic> json) {
    return Garment(
      id: json['id'] as int,
      imageUrl: json['image_url'] as String,
      subcategory: json['subcategory'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
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
