import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MediaPreviewScreen extends StatefulWidget {
  final String attachmentType;
  final String filePath;
  final String? caption;

  const MediaPreviewScreen({
    super.key,
    required this.attachmentType,
    required this.filePath,
    this.caption,
  });

  @override
  State<MediaPreviewScreen> createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen> {
  late final TextEditingController _captionController;

  bool _isEncrypted = true;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(
      text: widget.caption ?? '',
    );
  }

  // SEND HANDLER (SIMULATED)

  void _sendAttachment() {
    if (_isSending) return;

    setState(() => _isSending = true);

    final hasThreat = _simulateThreatDetection(widget.filePath);

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() => _isSending = false);

      if (hasThreat) {
        _navigateToThreatWarning();
      } else {
        Navigator.pop(context, _buildResult());
      }
    });
  }

  bool _simulateThreatDetection(String path) {
    final lower = path.toLowerCase();
    return lower.contains('final.pdf') ||
        lower.contains('malware') ||
        lower.contains('harmful');
  }

  Map<String, dynamic> _buildResult() {
    return {
      'type': widget.attachmentType,
      'filePath': widget.filePath,
      'caption': _captionController.text,
      'encrypted': _isEncrypted,
      'timestamp': DateTime.now(),
    };
  }

  void _navigateToThreatWarning() {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.threatWarning,
      arguments: {
        'type': 'malware',
        'fileName': _getFileName(),
        'fileSize': '140 KB',
        'description':
            'This file appears to contain harmful content. Opening it may compromise your device.',
        'senderName': 'You',
      },
    );
  }

  // UI HELPERS

  Widget _buildPreview() {
    switch (widget.attachmentType) {
      case 'document':
        return _DocumentPreview(fileName: _getFileName());
      case 'image':
        return const _ImagePreview();
      case 'audio':
        return const _IconPreview(
          icon: Icons.headphones,
          label: 'Audio File',
        );
      case 'video':
        return const _IconPreview(
          icon: Icons.videocam,
          label: 'Video File',
        );
      case 'location':
        return const _IconPreview(
          icon: Icons.location_on,
          label: 'Location Shared',
        );
      default:
        return const _IconPreview(
          icon: Icons.insert_drive_file,
          label: 'File Attachment',
        );
    }
  }

  String _getFileName() {
    return widget.filePath.split('/').last;
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // BUILD

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Preview ${_capitalize(widget.attachmentType)}'),
        actions: [
          _isSending
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendAttachment,
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildPreview(),
                    const SizedBox(height: 24),

                    TextField(
                      controller: _captionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Add a caption...',
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _EncryptionToggle(
                      value: _isEncrypted,
                      onChanged: (v) => setState(() => _isEncrypted = v),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendAttachment,
                child: Text(_isSending ? 'Sending…' : 'Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }
}

/// PREVIEW WIDGETS

class _DocumentPreview extends StatelessWidget {
  final String fileName;

  const _DocumentPreview({required this.fileName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.picture_as_pdf, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            fileName,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '140 KB • PDF Document',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        'https://picsum.photos/400/300',
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _IconPreview extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconPreview({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 80),
          const SizedBox(height: 16),
          Text(label, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _EncryptionToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _EncryptionToggle({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock,
            color: value ? Colors.green : theme.iconTheme.color,
          ),
          const SizedBox(width: 12),
          const Expanded(child: Text('Encrypted Before Send')),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
