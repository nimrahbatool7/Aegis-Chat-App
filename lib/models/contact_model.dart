class Contact {
  final String id;
  final String name;
  final String status;
  final String avatar;
  final bool isOnline;
  final bool isOnAegis;

  Contact({
    required this.id,
    required this.name,
    required this.status,
    required this.avatar,
    this.isOnline = false,
    this.isOnAegis = true,
  });
}