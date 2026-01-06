// lib/screens/user_management_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  int _selectedTab = 0; // 0: All, 1: Active, 2: Disabled
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by phone number or name...',
                hintStyle: TextStyle(color: AppColors.textSecondaryDark),
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondaryDark),
                filled: true,
                fillColor: AppColors.surfaceDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.accentGreen),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
              ),
              style: TextStyle(color: AppColors.textPrimaryDark),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildTab('All Users', 0),
                  _buildTab('Active', 1),
                  _buildTab('Disabled', 2),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCircle('1,247', 'Total Users', AppColors.accentBlue),
                _buildStatCircle('1,189', 'Active', AppColors.accentGreen),
                _buildStatCircle('58', 'Disabled', Colors.redAccent),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Text(
                  'Users',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_getUserCount()} users found',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // User List
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _selectedTab == index
                ? AppColors.accentBlue
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _selectedTab == index ? Colors.white : AppColors.textSecondaryDark,
              fontWeight: _selectedTab == index ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCircle(String value, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            color: color.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildUserList() {
    final users = _getFilteredUsers();
    
    if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: AppColors.textSecondaryDark,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No users found for "$_searchQuery"'
                  : 'No users in this category',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildUserTile(
          user['phone'],
          user['date'],
          user['isDisabled'],
          user['name'],
        );
      },
    );
  }

  Widget _buildUserTile(String phoneNumber, String registrationDate, bool isDisabled, String name) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.userDetails,
        arguments: {
          'phoneNumber': phoneNumber,
          'registrationDate': registrationDate,
          'isDisabled': isDisabled,
          'name': name,
        },
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: isDisabled
                  ? Colors.redAccent.withOpacity(0.2)
                  : AppColors.accentBlue.withOpacity(0.2),
              child: Icon(
                isDisabled ? Icons.block : Icons.person,
                color: isDisabled ? Colors.redAccent : AppColors.accentBlue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    registrationDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDisabled
                    ? Colors.redAccent.withOpacity(0.2)
                    : AppColors.accentGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                isDisabled ? 'Disabled' : 'Active',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDisabled ? Colors.redAccent : AppColors.accentGreen,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondaryDark,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredUsers() {
    // Sample user data
    List<Map<String, dynamic>> allUsers = [
      {
        'phone': '+92 300 1234567',
        'date': 'Registered: Nov 2, 2024',
        'isDisabled': false,
        'name': 'Nimrah Batool'
      },
      {
        'phone': '+92 331 9876543',
        'date': 'Registered: Nov 22, 2024',
        'isDisabled': false,
        'name': 'M. Huzafia Jawed'
      },
      {
        'phone': '+92 333 4567890',
        'date': 'Registered: Nov 22, 2024',
        'isDisabled': true,
        'name': 'Talat Hussain'
      },
      {
        'phone': '+92 332 1122334',
        'date': 'Registered: Nov 22, 2024',
        'isDisabled': false,
        'name': 'Sir Taimoor Riaz'
      },
      {
        'phone': '+92 330 9988776',
        'date': 'Registered: Nov 22, 2024',
        'isDisabled': false,
        'name': 'Sir Majid Zaman'
      },
    ];

    // Filter by search query
    List<Map<String, dynamic>> filtered = allUsers.where((user) {
      final query = _searchQuery.toLowerCase();
      return user['phone'].toLowerCase().contains(query) ||
             user['name'].toLowerCase().contains(query);
    }).toList();

    // Filter by tab selection
    if (_selectedTab == 1) {
      // Active users
      filtered = filtered.where((user) => !user['isDisabled']).toList();
    } else if (_selectedTab == 2) {
      // Disabled users
      filtered = filtered.where((user) => user['isDisabled']).toList();
    }

    return filtered;
  }

  int _getUserCount() {
    return _getFilteredUsers().length;
  }
}