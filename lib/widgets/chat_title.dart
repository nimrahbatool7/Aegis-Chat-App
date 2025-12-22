import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../utils/constants.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.accentGreen, 
        child: Text(
          chat.avatar,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Row(
        children: [
          Text(
            chat.name,
            style: TextStyle(
              fontWeight: chat.unreadCount > 0 
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
        chat.lastMessage,
        style: TextStyle(
          fontWeight: chat.unreadCount > 0 
              ? FontWeight.w600 
              : FontWeight.normal,
          color: chat.unreadCount > 0 
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
            chat.time,
            style: TextStyle(
              color: AppColors.textSecondaryDark, 
              fontSize: 12,
            ),
          ),
          if (chat.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.accentGreen, 
                shape: BoxShape.circle,
              ),
              child: Text(
                chat.unreadCount.toString(),
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