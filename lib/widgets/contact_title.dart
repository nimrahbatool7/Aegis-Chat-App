// lib/widgets/contact_tile.dart
import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../utils/constants.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onTap;
  final bool showInviteButton;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
    this.showInviteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: isDark ? AppColors.surfaceDark : Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            // Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getAvatarColor(contact, isDark),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  contact.avatar,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Online indicator
            if (contact.isOnAegis && contact.isOnline)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? AppColors.backgroundDark : Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Text(
              contact.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textPrimaryDark : Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            if (contact.isOnAegis)
              Icon(
                Icons.verified,
                size: 16,
                color: AppColors.accentGreen,
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Icon(
                _getStatusIcon(contact),
                size: 14,
                color: _getStatusColor(contact, isDark),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  contact.status,
                  style: TextStyle(
                    fontSize: 14,
                    color: _getStatusColor(contact, isDark),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        trailing: _buildTrailingWidget(contact, isDark),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Color _getAvatarColor(ContactModel contact, bool isDark) {
    if (!contact.isOnAegis) {
      return Colors.grey;
    }
    return isDark ? AppColors.accentBlue : AppColors.primaryLight;
  }

  Color _getStatusColor(ContactModel contact, bool isDark) {
    if (!contact.isOnAegis) {
      return AppColors.textDisabledDark;
    }
    if (contact.isOnline) {
      return isDark ? AppColors.accentGreen : AppColors.lightGreen;
    }
    return isDark ? AppColors.textSecondaryDark : Colors.grey;
  }

  IconData _getStatusIcon(ContactModel contact) {
    if (!contact.isOnAegis) {
      return Icons.error_outline;
    }
    if (contact.isOnline) {
      return Icons.circle;
    }
    return Icons.access_time;
  }

  Widget _buildTrailingWidget(ContactModel contact, bool isDark) {
    if (contact.isOnAegis) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.accentGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.chat,
          size: 20,
          color: AppColors.accentGreen,
        ),
      );
    } else if (showInviteButton) {
      return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accentGreen,
          side: BorderSide(color: AppColors.accentGreen),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Invite',
          style: TextStyle(fontSize: 14),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}