// lib/screens/user_details_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserDetailsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = userData['phoneNumber'] ?? '+92 300 *******';
    final registrationDate = userData['registrationDate'] ?? 'Nov 2, 2025';
    final isDisabled = (userData['isDisabled'] as bool?) ?? false;
    final userName = userData['name'] ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              _showMoreOptions(context);
            },
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            Card(
              color: AppColors.secondaryDark,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.accentBlue.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.accentBlue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phoneNumber,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Registered: $registrationDate',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? Colors.redAccent.withOpacity(0.2)
                            : AppColors.accentGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isDisabled ? 'Disabled' : 'Active',
                        style: TextStyle(
                          color: isDisabled ? Colors.redAccent : AppColors.accentGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Account Information
            Text(
              'Account Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 12),

            _buildInfoRow('User ID', 'USDA-B57223'),
            _buildInfoRow('Last Sign-in', '2 hours ago'),
            _buildInfoRow('Platform', 'Android'),
            _buildInfoRow('App Version', '1.0.0 (Beta)'),

            const SizedBox(height: 24),

            // Privacy Settings
            Text(
              'Privacy Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 12),

            Card(
              color: AppColors.secondaryDark,
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      'Privacy Preserving Data Access',
                      style: TextStyle(color: AppColors.textPrimaryDark),
                    ),
                    subtitle: Text(
                      'Controls how user data is accessed and processed',
                      style: TextStyle(color: AppColors.textSecondaryDark),
                    ),
                    value: true,
                    onChanged: (value) {
                      // Handle toggle
                    },
                    activeColor: AppColors.accentGreen,
                  ),
                  const Divider(height: 0, color: Colors.white12),
                  SwitchListTile(
                    title: Text(
                      'Encrypted Messages & History',
                      style: TextStyle(color: AppColors.textPrimaryDark),
                    ),
                    subtitle: Text(
                      'Applies to encrypted messages and chat history',
                      style: TextStyle(color: AppColors.textSecondaryDark),
                    ),
                    value: true,
                    onChanged: (value) {
                      // Handle toggle
                    },
                    activeColor: AppColors.accentGreen,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Security Actions
            if (isDisabled)
              ElevatedButton(
                onPressed: () => _showEnableAccountDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGreen,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Enable Account',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            else
              OutlinedButton(
                onPressed: () => _showDisableAccountDialog(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: BorderSide(color: Colors.redAccent),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Disable Account',
                  style: TextStyle(fontSize: 16),
                ),
              ),

            const SizedBox(height: 16),

            // Delete Account Button
            OutlinedButton(
              onPressed: () => _showDeleteAccountDialog(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Delete Account',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondaryDark,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: AppColors.accentBlue),
            title: Text(
              'Edit User Details',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Edit feature coming soon'),
                  backgroundColor: AppColors.accentGreen,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: AppColors.accentGreen),
            title: Text(
              'View Activity History',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to activity history
            },
          ),
          ListTile(
            leading: const Icon(Icons.security, color: Colors.amber),
            title: Text(
              'Security Settings',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to security settings
            },
          ),
          const Divider(color: Colors.white12),
          ListTile(
            leading: const Icon(Icons.close, color: Colors.grey),
            title: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showEnableAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondaryDark,
        title: Text(
          'Enable User Account?',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This will restore the user\'s access to their account.',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.accentBlue),
                  const SizedBox(width: 8),
                  Text(
                    'Last Location',
                    style: TextStyle(color: AppColors.textPrimaryDark),
                  ),
                  const Spacer(),
                  Text(
                    '+92 300 ******',
                    style: TextStyle(color: AppColors.textSecondaryDark),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account enabled successfully'),
                  backgroundColor: AppColors.accentGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
            ),
            child: const Text('Enable Account'),
          ),
        ],
      ),
    );
  }

  void _showDisableAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondaryDark,
        title: Text(
          'Disable User Account?',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'This will temporarily disable the user\'s account. '
          'They will not be able to sign in until the account is re-enabled.',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account disabled successfully'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: const Text('Disable Account'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondaryDark,
        title: Text(
          'Delete Account Permanently?',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          '⚠️ This action is irreversible!\n\n'
          'All user data, messages, and history will be permanently deleted.',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion feature coming soon'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}