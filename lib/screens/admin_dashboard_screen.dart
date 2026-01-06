// lib/screens/admin_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import './user_management_screen.dart';
import './system_health_screen.dart';
import './ml_analytics_screen.dart';
import './activity_summary_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundDark,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'Total Users',
                    value: '1,247',
                    icon: Icons.people,
                    color: AppColors.accentBlue,
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.userManagement),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: 'Active Users',
                    value: '1,189',
                    icon: Icons.check_circle,
                    color: AppColors.accentGreen,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'Disabled',
                    value: '58',
                    icon: Icons.block,
                    color: Colors.redAccent, // Fixed: Changed from AppColors.accentRed
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: 'Active Connections',
                    value: '1,847',
                    icon: Icons.link,
                    color: Colors.amber, // Fixed: Changed from AppColors.accentYellow
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.systemHealth),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Navigation Cards
            _buildNavCard(
              title: 'User Management',
              description: 'Manage user accounts and permissions',
              icon: Icons.manage_accounts,
              onTap: () => Navigator.pushNamed(context, AppRoutes.userManagement),
            ),
            
            const SizedBox(height: 12),
            
            _buildNavCard(
              title: 'System Health',
              description: 'Monitor system resources and performance',
              icon: Icons.monitor_heart,
              onTap: () => Navigator.pushNamed(context, AppRoutes.systemHealth),
            ),
            
            const SizedBox(height: 12),
            
            _buildNavCard(
              title: 'ML Model Analytics',
              description: 'View AI model performance and trends',
              icon: Icons.analytics,
              onTap: () => Navigator.pushNamed(context, AppRoutes.mlAnalytics),
            ),
            
            const SizedBox(height: 12),
            
            _buildNavCard(
              title: 'Activity Summary',
              description: 'View user activity and sign-in trends',
              icon: Icons.timeline,
              onTap: () => Navigator.pushNamed(context, AppRoutes.activitySummary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.accentBlue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondaryDark),
          ],
        ),
      ),
    );
  }
}