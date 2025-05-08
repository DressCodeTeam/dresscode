import 'package:dresscode/src/models/base.model.dart';
import 'package:dresscode/src/shared/extensions/json_extension.dart';

class Garment extends BaseModel {
  Garment({
    required this.id,
    required this.userId,
    required this.imageId,
    required this.subcategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Garment.empty() {
    return Garment(
      id: '',
      userId: '',
      imageId: -1,
      subcategoryId: -1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
    );
  }

  factory Garment.fromJSON(Map<String, dynamic> json) {
    return Garment(
      id: json.require<String>('id', className: 'Garment'),
      userId: json.require<String>('id_user', className: 'Garment'),
      imageId: json.require<int>('id_image', className: 'Garment'),
      subcategoryId: json.require<int>('id_subcategory', className: 'Garment'),
      createdAt: json.require<DateTime>('created_at', className: 'Garment'),
      updatedAt: json.require<DateTime>('updated_at', className: 'Garment')
    );
  }

  final String id;

  final String userId;

  final int imageId;

  final int subcategoryId;

  final DateTime createdAt;

  final DateTime updatedAt;

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'id_user': userId,
      'id_image': imageId,
      'id_subcategory': subcategoryId,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }
}
