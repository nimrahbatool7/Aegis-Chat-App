import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactProfileScreen extends StatelessWidget {
  final Contact contact;

  const ContactProfileScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          
            Container(
              padding: const EdgeInsets.all(24),
              color: theme.cardColor,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          contact.avatar,
                          style: theme.textTheme.headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      if (contact.isOnline)
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.scaffoldBackgroundColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    contact.name,
                    style: theme.textTheme.titleLarge,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    contact.isOnline ? 'Online' : contact.status,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: contact.isOnline
                          ? theme.colorScheme.primary
                          : theme.textTheme.bodyMedium!.color,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.chat),
                        label: const Text('Chat'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Voice calling coming soon'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.call),
                        label: const Text('Call'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Video calling coming soon'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.videocam),
                        label: const Text('Video'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            _Section(
              title: 'Contact Info',
              children: [
                _InfoRow(
                  icon: Icons.phone,
                  label: 'Phone Number',
                  value: '+92 300 XXXXXX',
                ),
                _InfoRow(
                  icon: Icons.access_time,
                  label: 'Last Seen',
                  value: contact.isOnline ? 'Online now' : contact.status,
                ),
                if (contact.isOnAegis)
                  const _InfoRow(
                    icon: Icons.verified,
                    label: 'Aegis Status',
                    value: 'Verified User',
                  ),
              ],
            ),

            const SizedBox(height: 8),

           
            _Section(
              title: 'Privacy & Actions',
              children: [
                _ActionTile(
                  icon: Icons.block,
                  title: 'Block Contact',
                  isDestructive: true,
                  onTap: () => _showBlockDialog(context, contact.name),
                ),
                _ActionTile(
                  icon: Icons.report,
                  title: 'Report Contact',
                  isDestructive: true,
                  onTap: () => _showReportDialog(context, contact.name),
                ),
                if (!contact.isOnAegis)
                  _ActionTile(
                    icon: Icons.person_add,
                    title: 'Invite to Aegis Chat',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Invitation sent to ${contact.name}'),
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


  void _showBlockDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Block Contact'),
        content: Text(
          'Are you sure you want to block $name? '
          'You will no longer receive messages from them.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$name blocked')),
              );
            },
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Report Contact'),
        content: Text('Report $name for inappropriate behavior?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Report submitted for $name')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}


class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: theme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: theme.iconTheme.color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(value, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDestructive;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? theme.colorScheme.error
            : theme.colorScheme.primary,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge!.copyWith(
          color: isDestructive
              ? theme.colorScheme.error
              : theme.textTheme.bodyLarge!.color,
        ),
      ),
      onTap: onTap,
    );
  }
}
