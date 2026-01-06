import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isFirstOfGroup;
  final bool isLastOfGroup;
  final String? senderInitials;

  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.isFirstOfGroup = true,
    this.isLastOfGroup = true,
    this.senderInitials = 'NB', // Default initials
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(
        top: isFirstOfGroup ? 8.0 : 2.0,
        bottom: isLastOfGroup ? 8.0 : 2.0,
        left: isMe ? 50.0 : 0.0,
        right: isMe ? 0.0 : 50.0,
      ),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Sender avatar (only for received messages and last in group)
          if (!isMe && isLastOfGroup)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: _getAvatarColor(isDark),
                child: Text(
                  senderInitials!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          
          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: _getBubbleColor(isDark, isMe),
                borderRadius: _getBorderRadius(isMe),
                boxShadow: [
                  if (isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    )
                  else
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: _getTextColor(isDark, isMe),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10,
                          color: _getTimeColor(isDark, isMe),
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.done_all,
                          size: 12,
                          color: _getStatusIconColor(isDark),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Read status icon (only for sent messages and last in group)
          if (isMe && isLastOfGroup)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(
                Icons.check_circle,
                size: 14,
                color: _getStatusIconColor(isDark),
              ),
            ),
        ],
      ),
    );
  }

  Color _getAvatarColor(bool isDark) {
    return isDark ? AppColors.accentGreen : AppColors.primaryLight;
  }

  Color _getBubbleColor(bool isDark, bool isMe) {
    if (isMe) {
      return isDark ? AppColors.myMessageDark : AppColors.myMessageLight;
    } else {
      return isDark ? AppColors.theirMessageDark : AppColors.theirMessageLight;
    }
  }

  Color _getTextColor(bool isDark, bool isMe) {
    if (isMe) {
      return isDark ? Colors.white : Colors.black87;
    } else {
      return isDark ? AppColors.textPrimaryDark : Colors.black87;
    }
  }

  Color _getTimeColor(bool isDark, bool isMe) {
    if (isMe) {
      return isDark ? Colors.white70 : Colors.black54;
    } else {
      return isDark ? AppColors.textSecondaryDark : Colors.black54;
    }
  }

  Color _getStatusIconColor(bool isDark) {
    return isDark ? AppColors.accentGreen : AppColors.primaryLight;
  }

  BorderRadius _getBorderRadius(bool isMe) {
    return BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4),
      bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18),
    );
  }
}