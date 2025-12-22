// lib/screens/user_profile_view_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class UserProfileViewScreen extends StatefulWidget {
  const UserProfileViewScreen({super.key});

  @override
  State<UserProfileViewScreen> createState() => _UserProfileViewScreenState();
}

class _UserProfileViewScreenState extends State<UserProfileViewScreen> {
  final String _userName = 'Nimrah Batool';
  final String _phoneNumber = '+92 300 1234567';
  final String _status = 'Busy right now, using Aegis Chat.';
  final String _avatar = 'NB';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // Navigate to edit profile screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Edit profile feature coming soon'),
                  backgroundColor: AppColors.surfaceDark,
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              color: AppColors.surfaceDark,
              child: Column(
                children: [
                  // Avatar
                  CircleAvatar(
                    backgroundColor: AppColors.accentGreen,
                    radius: 50,
                    child: Text(
                      _avatar,
                      style: const TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Name
                  Text(
                    _userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Status
                  Text(
                    _status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Start Chat Button
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Feature coming soon'),
                              backgroundColor: AppColors.surfaceDark,
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat, size: 20),
                        label: const Text('Start Chat'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentGreen,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      
                      // Call Button
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Voice calling coming soon'),
                              backgroundColor: AppColors.surfaceDark,
                            ),
                          );
                        },
                        icon: const Icon(Icons.call, size: 20, color: AppColors.accentGreen),
                        label: const Text('Call', style: TextStyle(color: AppColors.accentGreen)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.accentGreen),
                        ),
                      ),
                      
                      // Video Call Button
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Video calling coming soon'),
                              backgroundColor: AppColors.surfaceDark,
                            ),
                          );
                        },
                        icon: const Icon(Icons.videocam, size: 20, color: AppColors.accentGreen),
                        label: const Text('Video', style: TextStyle(color: AppColors.accentGreen)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.accentGreen),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Divider
            Container(height: 1, color: AppColors.dividerDark),
            
            // Contact Info Section
            _buildSection(
              title: 'Contact Info',
              children: [
                _buildInfoRow(
                  icon: Icons.phone,
                  label: 'Phone Number',
                  value: _phoneNumber,
                ),
                _buildInfoRow(
                  icon: Icons.access_time,
                  label: 'Last Seen',
                  value: 'Today at 5:45 PM',
                ),
              ],
            ),
            
            // Divider
            Container(height: 1, color: AppColors.dividerDark),
            
            // Status & Controls Section
            _buildSection(
              title: 'Status & Controls',
              children: [
                _buildListTile(
                  icon: Icons.mood,
                  title: 'Set Status',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Status update coming soon'),
                        backgroundColor: AppColors.surfaceDark,
                      ),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.notifications,
                  title: 'Mute Notifications',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: AppColors.accentGreen,
                  ),
                ),
              ],
            ),
            
            // Divider
            Container(height: 1, color: AppColors.dividerDark),
            
            // Privacy & Actions Section
            _buildSection(
              title: 'Privacy & Actions',
              children: [
                _buildListTile(
                  icon: Icons.block,
                  title: 'Block Contact',
                  color: Colors.red,
                  onTap: () {
                    _showBlockDialog(context);
                  },
                ),
                _buildListTile(
                  icon: Icons.report,
                  title: 'Report Contact',
                  color: Colors.orange,
                  onTap: () {
                    _showReportDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surfaceDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondaryDark,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondaryDark, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? color,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? AppColors.accentGreen,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color ?? AppColors.textPrimaryDark,
          fontWeight: color != null ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      tileColor: Colors.transparent,
    );
  }

  void _showBlockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Block Contact', style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Text(
          'Are you sure you want to block this contact? '
          'You will no longer receive messages from them.',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondaryDark)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Contact blocked successfully'),
                  backgroundColor: AppColors.accentGreen,
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Report Contact', style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Why are you reporting this contact?', style: TextStyle(color: AppColors.textSecondaryDark)),
            const SizedBox(height: 12),
            Text('• Spam or scam', style: TextStyle(color: AppColors.textPrimaryDark)),
            Text('• Harassment or bullying', style: TextStyle(color: AppColors.textPrimaryDark)),
            Text('• Inappropriate content', style: TextStyle(color: AppColors.textPrimaryDark)),
            Text('• Other reasons', style: TextStyle(color: AppColors.textPrimaryDark)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondaryDark)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Report submitted successfully'),
                  backgroundColor: AppColors.accentGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
            ),
            child: const Text('Submit Report'),
          ),
        ],
      ),
    );
  }
}