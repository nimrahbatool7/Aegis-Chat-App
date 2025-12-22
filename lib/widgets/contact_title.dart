import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../utils/constants.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.accentGreen,
        child: Text(
          contact.avatar,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.textPrimaryDark,
        ),
      ),
      subtitle: Row(
        children: [
          if (contact.isOnAegis)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: contact.isOnline ? Colors.green : AppColors.textSecondaryDark,
                shape: BoxShape.circle,
              ),
            ),
          if (contact.isOnAegis)
            const SizedBox(width: 6),
          Text(
            contact.status,
            style: TextStyle(
              color: contact.isOnAegis 
                  ? (contact.isOnline 
                      ? Colors.green  // Green for online
                      : AppColors.textSecondaryDark)  // Grey for offline
                  : AppColors.textDisabledDark,  // Dim for non-Aegis
              fontSize: 14,
            ),
          ),
        ],
      ),
      trailing: !contact.isOnAegis
          ? ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Invite',
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      tileColor: Colors.transparent,
    );
  }
}