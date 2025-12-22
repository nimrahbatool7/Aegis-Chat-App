import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  final List<String> _visibilityOptions = ['Everyone', 'My Contacts', 'Nobody'];

  String _lastSeen = 'Everyone';
  String _profilePhoto = 'Everyone';

  final Map<String, bool> _toggles = {
    'read_receipts': true,
    'typing': true,
    'screenshot': true,
    'session_alerts': true,
    'auto_delete': true,
  };

  void _updateToggle(String key, bool value) {
    if (!_toggles.containsKey(key)) return;
    setState(() => _toggles[key] = value);

    if (key == 'screenshot' && value) {
      // Ensure SnackBar shows after dialog pop
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Screenshot protection enabled'),
            backgroundColor: AppColors.accentGreen,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _section(
              'Account Privacy',
              [
                _valueTile('Last Seen', _lastSeen, () {
                  _showVisibilityDialog('Last Seen', _lastSeen, (v) {
                    setState(() => _lastSeen = v);
                  });
                }),
                _switchTile('Read Receipts', 'read_receipts'),
                _switchTile('Typing Indicators', 'typing'),
                _valueTile('Profile Photo', _profilePhoto, () {
                  _showVisibilityDialog('Profile Photo', _profilePhoto, (v) {
                    setState(() => _profilePhoto = v);
                  });
                }),
              ],
            ),
            _divider(),
            _section(
              'Advanced Privacy',
              [
                _switchTile(
                  'Screenshot Protection',
                  'screenshot',
                  subtitle:
                      'Prevents screenshots and disables preview in notifications.',
                ),
                _switchTile(
                  'Session Hijacking Alerts',
                  'session_alerts',
                  subtitle:
                      'Detects unusual login or cloned session attempts.',
                ),
              ],
            ),
            _divider(),
            _section(
              'Data Management',
              [
                _switchTile(
                  'Auto Delete Logs',
                  'auto_delete',
                  subtitle:
                      'Deletes sensitive encryption data after 7 days.',
                ),
                _dangerTile('Clear Chat History', _confirmClearHistory),
                _actionTile(
                  'Export My Data',
                  'Download a copy of your messages.',
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Export feature coming soon'),
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ======================= UI BUILDERS =======================
  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _switchTile(String title, String key, {String? subtitle}) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: _toggles[key] ?? false,
      activeColor: AppColors.primaryLight,
      onChanged: (v) => _updateToggle(key, v),
    );
  }

  Widget _valueTile(String title, String value, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _actionTile(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _dangerTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }

  Widget _divider() => const Divider(height: 8, thickness: 1);

  // ======================= DIALOGS =======================
  void _showVisibilityDialog(
    String title,
    String current,
    Function(String) onSelected,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        String temp = current;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('$title Visibility'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: _visibilityOptions
                  .map(
                    (o) => RadioListTile<String>(
                      title: Text(o),
                      value: o,
                      groupValue: temp,
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() => temp = v);
                        Navigator.pop(context);
                        onSelected(v);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _confirmClearHistory() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Chat History'),
        content:
            const Text('This action is permanent and cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Chat history cleared'),
                  backgroundColor: AppColors.accentGreen,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
