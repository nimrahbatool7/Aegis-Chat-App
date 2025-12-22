// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'privacy_settings_screen.dart';
import 'active_devices_screen.dart';
import 'session_expired_screen.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String _userName = 'Nimrah';
  bool _notificationsEnabled = true;
  bool _appLockEnabled = false;
  bool _twoStepVerification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Header
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.surfaceDark,
              child: Row(
                children: [
                  // User Avatar
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        _userName.substring(0, 2).toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Active on Aegis Chat',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Edit Button
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20, color: AppColors.textSecondaryDark),
                    onPressed: () {
                      // Navigate to profile edit
                    },
                  ),
                ],
              ),
            ),
            
            // General Section
            _buildSettingsSection(
              title: 'General',
              children: [
                _buildSettingsTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() => _notificationsEnabled = value);
                    },
                    activeColor: AppColors.accentGreen,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Notification settings coming soon'),
                        backgroundColor: AppColors.surfaceDark,
                      ),
                    );
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.privacy_tip,
                  title: 'Privacy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacySettingsScreen(),
                      ),
                    );
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.color_lens,
                  title: 'Appearance & Theme',
                  onTap: () {
                    _showThemeDialog(context);
                  },
                ),
              ],
            ),
            
            // Security Section
            _buildSettingsSection(
              title: 'Security',
              children: [
                _buildSettingsTile(
                  icon: Icons.lock,
                  title: 'App Lock',
                  trailing: Switch(
                    value: _appLockEnabled,
                    onChanged: (value) {
                      setState(() => _appLockEnabled = value);
                      if (value) {
                        _showAppLockSetupDialog(context);
                      }
                    },
                    activeColor: AppColors.accentGreen,
                  ),
                  onTap: () {
                    setState(() => _appLockEnabled = !_appLockEnabled);
                    if (!_appLockEnabled) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('App Lock disabled'),
                          backgroundColor: AppColors.accentGreen,
                        ),
                      );
                    }
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.devices,
                  title: 'Active Devices',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ActiveDevicesScreen(),
                      ),
                    );
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.verified_user,
                  title: 'Two-Step Verification',
                  trailing: Switch(
                    value: _twoStepVerification,
                    onChanged: (value) {
                      setState(() => _twoStepVerification = value);
                      if (value) {
                        _showTwoStepSetupDialog(context);
                      }
                    },
                    activeColor: AppColors.accentGreen,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Two-step verification setup coming soon'),
                        backgroundColor: AppColors.surfaceDark,
                      ),
                    );
                  },
                ),
              ],
            ),
            
            // Support Section
            _buildSettingsSection(
              title: 'Support',
              children: [
                _buildSettingsTile(
                  icon: Icons.help,
                  title: 'Help Center',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Help center coming soon'),
                        backgroundColor: AppColors.surfaceDark,
                      ),
                    );
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.description,
                  title: 'Terms & Policies',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Terms and policies coming soon'),
                        backgroundColor: AppColors.surfaceDark,
                      ),
                    );
                  },
                ),
              ],
            ),
            
            // Account Section
            _buildSettingsSection(
              title: 'Account',
              children: [
                _buildSettingsTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  color: AppColors.accentGreen,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.delete,
                  title: 'Delete Account',
                  color: Colors.red,
                  onTap: () {
                    _showDeleteAccountDialog(context);
                  },
                ),
                
                // Debug Option (For Testing)
                if (const bool.fromEnvironment('DEBUG', defaultValue: true))
                  _buildSettingsTile(
                    icon: Icons.bug_report,
                    title: 'Test Session Expired',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SessionExpiredScreen(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondaryDark,
              letterSpacing: 0.5,
            ),
          ),
        ),
        
        // Section Content
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? color,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? AppColors.textSecondaryDark,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color ?? AppColors.textPrimaryDark,
          fontWeight: color != null ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: trailing ?? Icon(
        Icons.chevron_right,
        color: AppColors.textSecondaryDark,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 0,
      tileColor: Colors.transparent,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Logout', style: TextStyle(color: AppColors.textPrimaryDark)),
        content: const Text(
          'Are you sure you want to logout? '
          'You will need to login again to use the app.',
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SessionExpiredScreen(),
                ),
                (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Delete Account', style: TextStyle(color: AppColors.textPrimaryDark)),
        content: const Text(
          '⚠️ Warning: This action is irreversible!\n\n'
          'All your messages, contacts, and data will be permanently deleted.\n'
          'You will not be able to recover your account.',
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
                  content: const Text('Account deletion feature coming soon'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    String selectedTheme = 'Dark'; // Default to dark theme
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.surfaceDark,
            title: const Text('Select Theme', style: TextStyle(color: AppColors.textPrimaryDark)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: const Text('Light Theme', style: TextStyle(color: AppColors.textPrimaryDark)),
                  value: 'Light',
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    setState(() => selectedTheme = value!);
                  },
                  activeColor: AppColors.accentGreen,
                ),
                RadioListTile(
                  title: const Text('Dark Theme', style: TextStyle(color: AppColors.textPrimaryDark)),
                  value: 'Dark',
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    setState(() => selectedTheme = value!);
                  },
                  activeColor: AppColors.accentGreen,
                ),
                RadioListTile(
                  title: const Text('System Default', style: TextStyle(color: AppColors.textPrimaryDark)),
                  value: 'System',
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    setState(() => selectedTheme = value!);
                  },
                  activeColor: AppColors.accentGreen,
                ),
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
                      content: Text('Theme changed to $selectedTheme'),
                      backgroundColor: AppColors.accentGreen,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGreen,
                ),
                child: const Text('Apply'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAppLockSetupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Setup App Lock', style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose your app lock method:', style: TextStyle(color: AppColors.textSecondaryDark)),
            const SizedBox(height: 16),
            Text('• PIN Code (Recommended)', style: TextStyle(color: AppColors.textPrimaryDark)),
            Text('• Pattern Lock', style: TextStyle(color: AppColors.textPrimaryDark)),
            Text('• Biometric (Fingerprint/Face ID)', style: TextStyle(color: AppColors.textPrimaryDark)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _appLockEnabled = false);
            },
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondaryDark)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('App Lock setup coming soon'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showTwoStepSetupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Two-Step Verification', style: TextStyle(color: AppColors.textPrimaryDark)),
        content: const Text(
          'Two-step verification adds an extra layer of security to your account. '
          'You will need to enter a code sent to your phone when logging in from a new device.',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _twoStepVerification = false);
            },
            child: const Text('Not Now', style: TextStyle(color: AppColors.textSecondaryDark)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Two-step verification setup coming soon'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
            ),
            child: const Text('Set Up'),
          ),
        ],
      ),
    );
  }
}