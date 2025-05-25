class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown',
      email: json['email']?.toString() ?? 'unknown@email.com',
      avatar: json['avatar']?.toString(),
      role: json['role']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'role': role,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
    );
  }
}