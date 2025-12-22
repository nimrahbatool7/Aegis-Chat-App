import 'package:flutter/material.dart';

import '../widgets/message_bubble.dart';
import '../models/chat_model.dart';
import 'media_attachment_options.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {'text': 'I wanted to discuss the project', 'time': '2:30 PM', 'isMe': false},
    {'text': 'Hi I\'m doing great thanks for asking', 'time': '2:31 PM', 'isMe': true},
    {'text': 'Sure, I\'m available to discuss.', 'time': '2:32 PM', 'isMe': false},
    {'text': 'What would you like to know?', 'time': '2:32 PM', 'isMe': true},
    {'text': 'Perfect! Can we schedule a call for tomorrow at 2 PM?', 'time': '2:33 PM', 'isMe': false},
    {'text': 'Meeting Tomorrow at Q210', 'time': '2:34 PM', 'isMe': false},
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'time': 'Now',
        'isMe': true,
      });
    });

    _messageController.clear();
  }

  void _showAttachmentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const MediaAttachmentOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: BackButton(),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                widget.chat.avatar,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.chat.name, style: theme.textTheme.titleMedium),
                Text(
                  'online',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.video_call),
          SizedBox(width: 8),
          Icon(Icons.call),
          SizedBox(width: 8),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          image: !isDark
              ? const DecorationImage(
                  image: AssetImage('assets/chat_bg.png'),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Column(
          children: [
            /// Messages
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return MessageBubble(
                    message: message['text'],
                    time: message['time'],
                    isMe: message['isMe'],
                    isFirstOfGroup: index == 0 ||
                        _messages[index - 1]['isMe'] != message['isMe'],
                    isLastOfGroup: index == _messages.length - 1 ||
                        _messages[index + 1]['isMe'] != message['isMe'],
                  );
                },
              ),
            ),

            /// Input bar
            SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                color: theme.cardColor,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: _showAttachmentSheet,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
