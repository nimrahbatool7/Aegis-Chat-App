// lib/data/models/contact_model.dart

class ContactModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final String status;
  final String avatar;
  final bool isOnline;
  final bool isOnAegis;
  final bool isVerified;
  final bool isBlocked;
  final String? publicKey;
  final DateTime? lastSeen;

  ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    required this.status,
    required this.avatar,
    this.isOnline = false,
    this.isOnAegis = false,
    this.isVerified = false,
    this.isBlocked = false,
    this.publicKey,
    this.lastSeen,
  });

  // From JSON
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? json['phoneNumber'] ?? '',
      email: json['email'],
      status: json['status'] ?? '',
      avatar: json['avatar'] ?? '',
      isOnline: json['is_online'] ?? json['isOnline'] ?? false,
      isOnAegis: json['is_on_aegis'] ?? json['isOnAegis'] ?? false,
      isVerified: json['is_verified'] ?? json['isVerified'] ?? false,
      isBlocked: json['is_blocked'] ?? json['isBlocked'] ?? false,
      publicKey: json['public_key'] ?? json['publicKey'],
      lastSeen: json['last_seen'] != null
          ? DateTime.parse(json['last_seen'])
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'status': status,
      'avatar': avatar,
      'is_online': isOnline,
      'is_on_aegis': isOnAegis,
      'is_verified': isVerified,
      'is_blocked': isBlocked,
      'public_key': publicKey,
      'last_seen': lastSeen?.toIso8601String(),
    };
  }

  // Copy with
  ContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? status,
    String? avatar,
    bool? isOnline,
    bool? isOnAegis,
    bool? isVerified,
    bool? isBlocked,
    String? publicKey,
    DateTime? lastSeen,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      status: status ?? this.status,
      avatar: avatar ?? this.avatar,
      isOnline: isOnline ?? this.isOnline,
      isOnAegis: isOnAegis ?? this.isOnAegis,
      isVerified: isVerified ?? this.isVerified,
      isBlocked: isBlocked ?? this.isBlocked,
      publicKey: publicKey ?? this.publicKey,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}
