import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AttachmentSheet extends StatelessWidget {
  const AttachmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(Icons.insert_drive_file, 'Document', () {}, isDark),
              _buildOption(Icons.camera_alt, 'Camera', () {}, isDark),
              _buildOption(Icons.photo, 'Gallery', () {}, isDark),
              _buildOption(Icons.headphones, 'Audio', () {}, isDark),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(Icons.location_on, 'Location', () {}, isDark),
              _buildOption(Icons.person, 'Contact', () {}, isDark),
              _buildOption(Icons.poll, 'Poll', () {}, isDark),
              _buildOption(Icons.attach_money, 'Payment', () {}, isDark),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: isDark ? AppColors.surfaceDark : Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.textPrimaryDark : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String label, VoidCallback onTap, bool isDark) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.grey[100],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon, 
              size: 30, 
              color: isDark ? AppColors.accentGreen : AppColors.primaryLight,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppColors.textSecondaryDark : Colors.grey[700],
          ),
        ),
      ],
    );
  }
}