import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isFirstOfGroup;
  final bool isLastOfGroup;

  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    this.isMe = false,
    this.isFirstOfGroup = true,
    this.isLastOfGroup = true,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if we're in dark mode (since your app forces dark mode)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Use dark theme colors (since your app forces dark mode)
    Color myMessageColor = AppColors.myMessageDark;
    Color theirMessageColor = AppColors.theirMessageDark;
    Color textColor = AppColors.textPrimaryDark;
    Color timeColor = AppColors.textSecondaryDark;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: isFirstOfGroup ? 4 : 1,
          bottom: isLastOfGroup ? 4 : 1,
          left: isMe ? 60 : 8,
          right: isMe ? 8 : 60,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isMe ? myMessageColor : theirMessageColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(4),
            bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Slightly darker for dark theme
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
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  color: timeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}