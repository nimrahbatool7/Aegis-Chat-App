import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../models/contact_model.dart';

class AppColors {
  static const Color accentRed = Color(0xFFF44336);

  static const Color primaryLight = Color(0xFF075E54);
  static const Color secondaryLight = Color(0xFF128C7E);
  static const Color lightGreen = Color(0xFF25D366);
  static const Color chatBgLight = Color(0xFFECE5DD);
  static const Color myMessageLight = Color(0xFFDCF8C6);
  static const Color theirMessageLight = Color.fromARGB(255, 14, 6, 6);

  static const Color primaryDark = Color(0xFF1F1F1F);
  static const Color secondaryDark = Color(0xFF242424);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF2D2D2D);
  static const Color myMessageDark = Color(0xFF075E54);
  static const Color theirMessageDark = Color(0xFF242424);

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA0A0A0);
  static const Color textDisabledDark = Color(0xFF666666);

  static const Color dividerDark = Color(0xFF333333);
  static const Color accentGreen = Color(0xFF25D366);
  static const Color accentBlue = Color(0xFF34B7F1);
}

class AppRoutes {
  static const login = '/login';
  static const contacts = '/contacts';
  static const chatList = '/chatlist';
  static const chat = '/chat';
  static const profile = '/profile';
  static const verify = '/verify';
  static const mediaPreview = '/media-preview';
  static const threatWarning = '/threat-warning';

  static const adminDashboard = '/admin-dashboard';
  static const userManagement = '/user-management';
  static const userDetails = '/user-details';
  static const systemHealth = '/system-health';
  static const mlAnalytics = '/ml-analytics';
  static const activitySummary = '/activity-summary';
}

class DummyData {
  static List<ChatModel> chats = [
    ChatModel(
      id: '1',
      name: 'Nimrah Batool',
      lastMessage: 'I wanted to discuss the project',
      lastMessageTime: '2:35 PM',
      avatar: 'NB',
      unreadCount: 1,
    ),
    ChatModel(
      id: '2',
      name: 'Team Alpha',
      lastMessage: 'Thanks for the update',
      lastMessageTime: '1:15 PM',
      avatar: 'TA',
      isGroup: true,
      unreadCount: 3,
    ),
    ChatModel(
      id: '3',
      name: 'Sir Taimoor',
      lastMessage: 'Can you review the document?',
      lastMessageTime: '11:12 AM',
      avatar: 'ST',
      unreadCount: 0,
    ),
    ChatModel(
      id: '4',
      name: 'Talat Hussain',
      lastMessage: 'New modules are ready',
      lastMessageTime: 'Wednesday',
      avatar: 'TH',
      unreadCount: 0,
    ),
    ChatModel(
      id: '5',
      name: 'M. Huzafia Jawed',
      lastMessage: 'Perfect, talk to you soon',
      lastMessageTime: 'Wednesday',
      avatar: 'MH',
      unreadCount: 0,
    ),
    ChatModel(
      id: '6',
      name: 'Unknown Contact',
      lastMessage: 'The presentation for tomorrow',
      lastMessageTime: 'Monday',
      avatar: 'UC',
      unreadCount: 2,
    ),
    ChatModel(
      id: '7',
      name: 'Sarah Khan',
      lastMessage: 'Meeting at 3 PM tomorrow',
      lastMessageTime: 'Yesterday',
      avatar: 'SK',
      unreadCount: 1,
    ),
    ChatModel(
      id: '8',
      name: 'Ahmed Ali',
      lastMessage: 'Files uploaded successfully',
      lastMessageTime: '2 days ago',
      avatar: 'AA',
      unreadCount: 0,
    ),
  ];

  static List<ContactModel> contacts = [
    ContactModel(
      id: '1',
      name: 'Nimrah',
      phoneNumber: '+92 300 1234567',
      status: 'online',
      avatar: 'N',
      isOnline: true,
      isOnAegis: true,
    ),
    ContactModel(
      id: '2',
      name: 'huzaifa jawed',
      phoneNumber: '+92 300 2234567',
      status: 'Active 2h ago',
      avatar: 'HJ',
      isOnAegis: true,
    ),
    ContactModel(
      id: '3',
      name: 'Talat Hussain',
      phoneNumber: '+92 300 3234567',
      status: 'online',
      avatar: 'TH',
      isOnline: true,
      isOnAegis: true,
    ),
    ContactModel(
      id: '4',
      name: 'Sir Taimoor Riaz',
      phoneNumber: '+92 300 4234567',
      status: 'Active 14 min ago',
      avatar: 'ST',
      isOnAegis: true,
    ),

    // Not on Aegis (Invite Friends)
    ContactModel(
      id: '5',
      name: 'Sir Majid Zaman',
      phoneNumber: '+92 300 5234567',
      status: 'Not on Aegis',
      avatar: 'SM',
      isOnAegis: false,
    ),
    ContactModel(
      id: '6',
      name: 'Michael Brown',
      phoneNumber: '+92 300 6234567',
      status: 'Not on Aegis',
      avatar: 'MB',
      isOnAegis: false,
    ),
    // More non-Aegis contacts
    ContactModel(
      id: '7',
      name: 'Sarah Khan',
      phoneNumber: '+92 300 7234567',
      status: 'Not on Aegis',
      avatar: 'SK',
      isOnAegis: false,
    ),
    ContactModel(
      id: '8',
      name: 'Ahmed ',
      phoneNumber: '+92 300 8234567',
      status: 'Not on Aegis',
      avatar: 'AA',
      isOnAegis: false,
    ),
    ContactModel(
      id: '9',
      name: 'amina',
      phoneNumber: '+92 300 9234567',
      status: 'Not on Aegis',
      avatar: 'EW',
      isOnAegis: false,
    ),
    ContactModel(
      id: '10',
      name: 'samia',
      phoneNumber: '+92 301 0234567',
      status: 'Not on Aegis',
      avatar: 'DS',
      isOnAegis: false,
    ),
  ];
}