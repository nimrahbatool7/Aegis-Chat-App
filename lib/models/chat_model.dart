// lib/data/models/chat_model.dart

class ChatModel {
  final String id;
  final String name;
  final String? lastMessage;
  final DateTime? lastMessageTimestamp;
  final String? lastMessageTime; // Formatted time string
  final String avatar;
  final bool isGroup;
  final int unreadCount;
  final List<String> participantIds;
  final bool isMuted;
  final bool isPinned;
  final String? encryptionKeyId;

  ChatModel({
    required this.id,
    required this.name,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.lastMessageTime,
    required this.avatar,
    this.isGroup = false,
    this.unreadCount = 0,
    this.participantIds = const [],
    this.isMuted = false,
    this.isPinned = false,
    this.encryptionKeyId,
  });

  // From JSON
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastMessage: json['last_message'] ?? json['lastMessage'],
      lastMessageTimestamp: json['last_message_timestamp'] != null
          ? DateTime.parse(json['last_message_timestamp'])
          : null,
      lastMessageTime: json['last_message_time'] ?? json['time'],
      avatar: json['avatar'] ?? '',
      isGroup: json['is_group'] ?? json['isGroup'] ?? false,
      unreadCount: json['unread_count'] ?? json['unreadCount'] ?? 0,
      participantIds: json['participant_ids'] != null
          ? List<String>.from(json['participant_ids'])
          : [],
      isMuted: json['is_muted'] ?? json['isMuted'] ?? false,
      isPinned: json['is_pinned'] ?? json['isPinned'] ?? false,
      encryptionKeyId: json['encryption_key_id'] ?? json['encryptionKeyId'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_message': lastMessage,
      'last_message_timestamp': lastMessageTimestamp?.toIso8601String(),
      'last_message_time': lastMessageTime,
      'avatar': avatar,
      'is_group': isGroup,
      'unread_count': unreadCount,
      'participant_ids': participantIds,
      'is_muted': isMuted,
      'is_pinned': isPinned,
      'encryption_key_id': encryptionKeyId,
    };
  }

  // Copy with
  ChatModel copyWith({
    String? id,
    String? name,
    String? lastMessage,
    DateTime? lastMessageTimestamp,
    String? lastMessageTime,
    String? avatar,
    bool? isGroup,
    int? unreadCount,
    List<String>? participantIds,
    bool? isMuted,
    bool? isPinned,
    String? encryptionKeyId,
  }) {
    return ChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      avatar: avatar ?? this.avatar,
      isGroup: isGroup ?? this.isGroup,
      unreadCount: unreadCount ?? this.unreadCount,
      participantIds: participantIds ?? this.participantIds,
      isMuted: isMuted ?? this.isMuted,
      isPinned: isPinned ?? this.isPinned,
      encryptionKeyId: encryptionKeyId ?? this.encryptionKeyId,
    );
  }
}

