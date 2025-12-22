import 'package:flutter/material.dart';

import '../widgets/chat_title.dart';
import '../utils/constants.dart';
import 'contacts_screen.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aegis Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            color: theme.cardColor,
            child: Row(
              children: [
                _TopNavButton(
                  icon: Icons.camera_alt,
                  label: 'Status',
                  onPressed: () {},
                ),
                _TopNavButton(
                  icon: Icons.chat,
                  label: 'Chats',
                  isActive: true,
                  onPressed: () {},
                ),
                _TopNavButton(
                  icon: Icons.call,
                  label: 'Calls',
                  onPressed: () {},
                ),
              ],
            ),
          ),

          /// Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages or users',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),

          /// Chat list
          Expanded(
            child: ListView.builder(
              itemCount: DummyData.chats.length,
              itemBuilder: (context, index) {
                final chat = DummyData.chats[index];
                return ChatTile(
                  chat: chat,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(chat: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ContactsScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
class _TopNavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  const _TopNavButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 20,
          color: isActive
              ? theme.colorScheme.primary
              : theme.textTheme.bodyMedium!.color,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: isActive
                ? theme.colorScheme.primary
                : theme.textTheme.bodyMedium!.color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
