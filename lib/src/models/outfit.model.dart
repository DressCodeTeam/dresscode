import 'package:dresscode/src/models/base.model.dart';
import 'package:dresscode/src/models/garment.model.dart';

class Outfit extends BaseModel {
  Outfit({
    required this.id,
    required this.style,
    required this.garments,
    required this.createdAt,
  });

  factory Outfit.empty() {
    return Outfit(
      id: -1,
      style: '',
      garments: [],
      createdAt: DateTime.now(),
    );
  }

  factory Outfit.fromJSON(Map<String, dynamic> json) {
    print('Parsing Outfit from JSON: $json');
    
    try {
      // Gestion de l'ID
      final int id = json['id'] as int? ?? -1;

      // Gestion du style
      final String style = json['style']?.toString() ?? 'Inconnu';

      // Gestion des garments - API format spécifique
      final List<Garment> garments;
      if (json['garments'] is List) {
        garments = (json['garments'] as List<dynamic>)
            .where((item) => item != null && item is Map<String, dynamic>)
            .map((garmentData) {
              final garmentMap = garmentData as Map<String, dynamic>;
              
              // L'API /outfits ne retourne que id et image_url pour les garments
              // Utilisez Garment.fromOutfitAPI() si vous créez cette factory
              // ou créez directement l'objet avec des valeurs par défaut
              return Garment(
                id: garmentMap['id'] as int,
                imageUrl: garmentMap['image_url'] as String,
                subcategory: '', // Valeur par défaut car non fournie par l'API
                description: null, // Optionnel, donc null
                createdAt: DateTime.now(), // Valeur par défaut
              );
            })
            .toList();
      } else {
        garments = [];
      }

      // Gestion de la date - format "2025-05-12" (sans heure)
      DateTime createdAt;
      if (json['created_at'] is String && (json['created_at'] as String).isNotEmpty) {
        try {
          final dateString = json['created_at'] as String;
          // Si c'est juste une date (YYYY-MM-DD), ajouter l'heure
          if (dateString.length == 10 && !dateString.contains('T')) {
            createdAt = DateTime.parse('${dateString}T00:00:00Z');
          } else {
            createdAt = DateTime.parse(dateString);
          }
        } catch (e) {
          print('Erreur parsing date: $e, value: ${json['created_at']}');
          createdAt = DateTime.now();
        }
      } else {
        createdAt = DateTime.now();
      }

      return Outfit(
        id: id,
        style: style,
        garments: garments,
        createdAt: createdAt,
      );
    } catch (e) {
      print('Erreur dans Outfit.fromJSON: $e');
      print('JSON reçu: $json');
      rethrow;
    }
  }

  final int id;
  final String style;
  final List<Garment> garments;
  final DateTime createdAt;

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'style': style,
      'garments': garments.map((garment) => garment.toJSON()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Outfit{id: $id, style: $style, garments: ${garments.length}, createdAt: $createdAt}';
  }
}