class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  final bool isGroup;
  final int unreadCount;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    this.isGroup = false,
    this.unreadCount = 0,
  });
}