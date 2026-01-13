import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../models/contact_model.dart';
import '../utils/constants.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final ContactModel contact;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.chat,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/contact-profile',
            arguments: contact,
          );
        },
        child: CircleAvatar(
          backgroundColor: AppColors.accentGreen, 
          child: Text(
            chat.avatar,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            chat.name,
            style: TextStyle(
              // FIX: Use (chat.unreadCount ?? 0) > 0
              fontWeight: (chat.unreadCount ?? 0) > 0 
                  ? FontWeight.bold 
                  : FontWeight.normal,
              fontSize: 16,
              color: AppColors.textPrimaryDark,
            ),
          ),
          if (chat.isGroup)
            const SizedBox(width: 8),
          if (chat.isGroup)
            Icon(Icons.group, size: 16, color: AppColors.textSecondaryDark),
        ],
      ),
      subtitle: Text(
        chat.lastMessage ?? '',
        style: TextStyle(
          // FIX: Use (chat.unreadCount ?? 0) > 0
          fontWeight: (chat.unreadCount ?? 0) > 0
              ? FontWeight.w600
              : FontWeight.normal,
          color: (chat.unreadCount ?? 0) > 0
              ? AppColors.textPrimaryDark
              : AppColors.textSecondaryDark,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat.lastMessageTime ?? '',
            style: const TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 12,
            ),
          ),
          // FIX: Use (chat.unreadCount ?? 0) > 0
          if ((chat.unreadCount ?? 0) > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
              ),
              child: Text(
                // FIX: Use (chat.unreadCount ?? 0).toString()
                (chat.unreadCount ?? 0).toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      tileColor: Colors.transparent,
    );
  }
}