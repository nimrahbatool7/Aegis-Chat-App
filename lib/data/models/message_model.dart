// lib/data/models/message_model.dart

enum MessageType { text, image, video, audio, document, location }
enum MessageStatus { sending, sent, delivered, read, failed }

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String content; // Encrypted content
  final MessageType type;
  final MessageStatus status;
  final DateTime timestamp;
  final String? replyToMessageId;
  final List<String>? attachmentUrls;
  final bool isEncrypted;
  final String? encryptionKeyId;
  final bool isDeleted;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    this.type = MessageType.text,
    this.status = MessageStatus.sending,
    required this.timestamp,
    this.replyToMessageId,
    this.attachmentUrls,
    this.isEncrypted = true,
    this.encryptionKeyId,
    this.isDeleted = false,
  });

  // From JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      chatId: json['chat_id'] ?? json['chatId'] ?? '',
      senderId: json['sender_id'] ?? json['senderId'] ?? '',
      content: json['content'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == (json['type'] ?? 'text'),
        orElse: () => MessageType.text,
      ),
      status: MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == (json['status'] ?? 'sent'),
        orElse: () => MessageStatus.sent,
      ),
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      replyToMessageId: json['reply_to_message_id'] ?? json['replyToMessageId'],
      attachmentUrls: json['attachment_urls'] != null
          ? List<String>.from(json['attachment_urls'])
          : null,
      isEncrypted: json['is_encrypted'] ?? json['isEncrypted'] ?? true,
      encryptionKeyId: json['encryption_key_id'] ?? json['encryptionKeyId'],
      isDeleted: json['is_deleted'] ?? json['isDeleted'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'content': content,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'reply_to_message_id': replyToMessageId,
      'attachment_urls': attachmentUrls,
      'is_encrypted': isEncrypted,
      'encryption_key_id': encryptionKeyId,
      'is_deleted': isDeleted,
    };
  }

  // Copy with
  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? content,
    MessageType? type,
    MessageStatus? status,
    DateTime? timestamp,
    String? replyToMessageId,
    List<String>? attachmentUrls,
    bool? isEncrypted,
    String? encryptionKeyId,
    bool? isDeleted,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      encryptionKeyId: encryptionKeyId ?? this.encryptionKeyId,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
