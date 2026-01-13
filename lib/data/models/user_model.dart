// lib/data/models/user_model.dart

class UserModel {
  final String id;
  final String phoneNumber;
  final String? email;
  final String name;
  final String? profilePhotoUrl;
  final String? bio;
  final String? publicKey;
  final DateTime createdAt;
  final DateTime? lastSeen;
  final bool isOnline;
  final bool isVerified;
  final String role; // 'user', 'admin', 'super_admin'

  UserModel({
    required this.id,
    required this.phoneNumber,
    this.email,
    required this.name,
    this.profilePhotoUrl,
    this.bio,
    this.publicKey,
    required this.createdAt,
    this.lastSeen,
    this.isOnline = false,
    this.isVerified = false,
    this.role = 'user',
  });

  // Check if user is admin
  bool get isAdmin => role == 'admin' || role == 'super_admin';

  // Check if user is super admin
  bool get isSuperAdmin => role == 'super_admin';

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      phoneNumber: json['phone_number'] ?? json['phoneNumber'] ?? '',
      email: json['email'],
      name: json['name'] ?? '',
      profilePhotoUrl: json['profile_photo_url'] ?? json['profilePhotoUrl'],
      bio: json['bio'],
      publicKey: json['public_key'] ?? json['publicKey'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      lastSeen: json['last_seen'] != null
          ? DateTime.parse(json['last_seen'])
          : null,
      isOnline: json['is_online'] ?? json['isOnline'] ?? false,
      isVerified: json['is_verified'] ?? json['isVerified'] ?? false,
      role: json['role'] ?? 'user',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'email': email,
      'name': name,
      'profile_photo_url': profilePhotoUrl,
      'bio': bio,
      'public_key': publicKey,
      'created_at': createdAt.toIso8601String(),
      'last_seen': lastSeen?.toIso8601String(),
      'is_online': isOnline,
      'is_verified': isVerified,
      'role': role,
    };
  }

  // Copy with
  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? email,
    String? name,
    String? profilePhotoUrl,
    String? bio,
    String? publicKey,
    DateTime? createdAt,
    DateTime? lastSeen,
    bool? isOnline,
    bool? isVerified,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      name: name ?? this.name,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      bio: bio ?? this.bio,
      publicKey: publicKey ?? this.publicKey,
      createdAt: createdAt ?? this.createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
      isVerified: isVerified ?? this.isVerified,
      role: role ?? this.role,
    );
  }
}
