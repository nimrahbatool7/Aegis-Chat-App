import 'package:flutter/material.dart';
import '../widgets/contact_title.dart'; 
import '../utils/constants.dart'; 
import 'chat_screen.dart';
import '../models/chat_model.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contactsList = DummyData.contacts ?? []; 

    final aegisContacts = contactsList.where((c) => c.isOnAegis).toList();
    final nonAegisContacts = contactsList.where((c) => !c.isOnAegis).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark, 
        foregroundColor: Colors.white, 
        title: const Text('Contacts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.backgroundDark, 
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search contacts',
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondaryDark),
                filled: true,
                fillColor: AppColors.surfaceDark,
                hintStyle: const TextStyle(color: AppColors.textDisabledDark),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                focusedBorder: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: AppColors.accentGreen),
                ),
              ),
              style: const TextStyle(color: AppColors.textPrimaryDark), 
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'On Aegis Chat',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondaryDark, 
                  ),
                ),
                const Spacer(),
                Text(
                  '${aegisContacts.length} contacts',
                  style: TextStyle(
                    fontSize: 12, 
                    color: AppColors.textSecondaryDark, 
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: aegisContacts.length,
              itemBuilder: (context, index) {
                final contact = aegisContacts[index];
                return ContactTile(
                  contact: contact,
                  onTap: () {
                    final chatList = DummyData.chats ?? [];
                    final chat = chatList.firstWhere(
                      (c) => c.name == contact.name,
                      orElse: () => Chat(
                        id: contact.id,
                        name: contact.name,
                        lastMessage: 'Start a conversation',
                        time: 'Now',
                        avatar: contact.avatar,
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(chat: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: AppColors.surfaceDark, 
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite Friends',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondaryDark, 
                  ),
                ),
                const SizedBox(height: 8),
                ...nonAegisContacts.map(
                  (contact) => ContactTile(
                    contact: contact,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/contact-profile',
                        arguments: contact, 
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}