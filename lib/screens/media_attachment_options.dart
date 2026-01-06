import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MediaAttachmentOptions extends StatelessWidget {
  final Function(String type, {String? filePath})? onAttachmentSelected;
  
  const MediaAttachmentOptions({
    super.key,
    this.onAttachmentSelected,
  });

void _handleAttachmentTap(String type, BuildContext context) {
  Navigator.pop(context); // Close bottom sheet
  
  Navigator.pushNamed(
    context,
    AppRoutes.mediaPreview,
    arguments: {
      'type': type,
      'filePath': type == 'document' 
        ? 'Project_Send_new_request_final.pdf' 
        : 'path/to/sample/file.jpg',
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attach File',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Attachment Options Grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildAttachmentOption(
                  icon: Icons.insert_drive_file,
                  label: 'Document',
                  color: Colors.blue,
                  onTap: () => _handleAttachmentTap('document', context),
                ),
                _buildAttachmentOption(
                  icon: Icons.photo,
                  label: 'Gallery',
                  color: Colors.green,
                  onTap: () => _handleAttachmentTap('gallery', context),
                ),
                _buildAttachmentOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  color: Colors.purple,
                  onTap: () => _handleAttachmentTap('camera', context),
                ),
                _buildAttachmentOption(
                  icon: Icons.headphones,
                  label: 'Audio',
                  color: Colors.orange,
                  onTap: () => _handleAttachmentTap('audio', context),
                ),
                _buildAttachmentOption(
                  icon: Icons.location_on,
                  label: 'Location',
                  color: Colors.red,
                  onTap: () => _handleAttachmentTap('location', context),
                ),
                _buildAttachmentOption(
                  icon: Icons.person,
                  label: 'Contact',
                  color: Colors.teal,
                  onTap: () => _handleAttachmentTap('contact', context),
                ),
                _buildAttachmentOption(
                  icon: Icons.poll,
                  label: 'Poll',
                  color: Colors.pink,
                  onTap: () => _handleAttachmentTap('poll', context),
                ),
                _buildAttachmentOption(
                  icon: Icons.attach_money,
                  label: 'Payment',
                  color: Colors.amber,
                  onTap: () => _handleAttachmentTap('payment', context),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Cancel Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}