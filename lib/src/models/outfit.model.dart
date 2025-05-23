import 'package:dresscode/src/models/base.model.dart';
import 'package:dresscode/src/shared/extensions/json_extension.dart';

class Outfit extends BaseModel {
  Outfit({
    required this.id,
    required this.styleId,
    required this.createdAt,
  });

  factory Outfit.empty() {
    return Outfit(
      id: -1,
      styleId: -1,
      createdAt: DateTime.now(),
    );
  }

  factory Outfit.fromJSON(Map<String, dynamic> json) {
    return Outfit(
      id: json.require<int>('id', className: 'Outfit'),
      styleId: json.require<int>('id_style', className: 'Outfit'),
      createdAt: json.require<DateTime>('created_at', className: 'Outfit'),
    );
  }

  final int id;
  final int styleId;
  final DateTime createdAt;

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'id_style': styleId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}