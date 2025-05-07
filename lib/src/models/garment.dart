class Garment {
  final int id;
  final String idUser;
  final int idImage;
  final int idSubcategory;
  final DateTime createdAt;
  final DateTime updatedAt;

  Garment({
    required this.id,
    required this.idUser,
    required this.idImage,
    required this.idSubcategory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Garment.fromJson(Map<String, dynamic> json) {
    return Garment(
      id: json['id'] as int,
      idUser: json['id_user'] as String,
      idImage: json['id_image'] as int,
      idSubcategory: json['id_subcategory'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'id_image': idImage,
      'id_subcategory': idSubcategory,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
