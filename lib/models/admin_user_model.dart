// lib/models/admin_user_model.dart

import '../data/models/user_model.dart';

enum AdminRole { superAdmin, moderator, support }

class AdminUserModel extends UserModel {
  final AdminRole adminRole;
  final List<String> permissions;
  final DateTime assignedAt;
  final String? assignedBy;

  AdminUserModel({
    required super.id,
    required super.phoneNumber,
    super.email,
    required super.name,
    super.profilePhotoUrl,
    super.bio,
    super.publicKey,
    required super.createdAt,
    super.lastSeen,
    super.isOnline,
    super.isVerified,
    super.role = 'admin',
    required this.adminRole,
    required this.permissions,
    required this.assignedAt,
    this.assignedBy,
  });

  // From JSON
  factory AdminUserModel.fromJson(Map<String, dynamic> json) {
    return AdminUserModel(
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
      role: json['role'] ?? 'admin',
      adminRole: AdminRole.values.firstWhere(
        (e) => e.toString().split('.').last == (json['admin_role'] ?? 'moderator'),
        orElse: () => AdminRole.moderator,
      ),
      permissions: json['permissions'] != null
          ? List<String>.from(json['permissions'])
          : [],
      assignedAt: json['assigned_at'] != null
          ? DateTime.parse(json['assigned_at'])
          : DateTime.now(),
      assignedBy: json['assigned_by'],
    );
  }

  // To JSON
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'admin_role': adminRole.toString().split('.').last,
      'permissions': permissions,
      'assigned_at': assignedAt.toIso8601String(),
      'assigned_by': assignedBy,
    });
    return json;
  }

  // Check permissions
  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }

  // Check if super admin
  bool get isSuperAdmin => adminRole == AdminRole.superAdmin;
}
