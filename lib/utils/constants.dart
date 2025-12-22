import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../models/contact_model.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF075E54);
  static const Color secondaryLight = Color(0xFF128C7E);
  static const Color lightGreen = Color(0xFF25D366);
  static const Color chatBgLight = Color(0xFFECE5DD);
  static const Color myMessageLight = Color(0xFFDCF8C6);
  static const Color theirMessageLight = Color(0xFFFFFFFF);

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
}

class DummyData {
  static List<Chat> chats = [
    Chat(
      id: '1',
      name: 'Nimrah Batool',
      lastMessage: 'I wanted to discuss the project',
      time: '2:35 PM',
      avatar: 'NB',
      unreadCount: 1,
    ),
    Chat(
      id: '2',
      name: 'Team Alpha',
      lastMessage: 'Thanks for the update',
      time: '1:15 PM',
      avatar: 'TA',
      isGroup: true,
    ),
    Chat(
      id: '3',
      name: 'Sir Taimoor',
      lastMessage: 'Can you review the document?',
      time: '11:12 AM',
      avatar: 'ST',
    ),
    Chat(
      id: '4',
      name: 'Talat Hussain',
      lastMessage: 'New modules are ready',
      time: 'Wednesday',
      avatar: 'TH',
    ),
    Chat(
      id: '5',
      name: 'M. Huzafia Jawed',
      lastMessage: 'Perfect, talk to you soon',
      time: 'Wednesday',
      avatar: 'MH',
    ),
    Chat(
      id: '6',
      name: 'Unknown Contact',
      lastMessage: 'The presentation for tomorrow',
      time: 'Monday',
      avatar: 'UC',
    ),
  ];

  static List<Contact> contacts = [
    Contact(
      id: '1',
      name: 'M. Huzafia Jawed',
      status: 'online',
      avatar: 'MH',
      isOnline: true,
    ),
    Contact(
      id: '2',
      name: 'Nimrah Batool',
      status: 'Active 2h ago',
      avatar: 'NB',
      isOnAegis: true,
    ),
    Contact(
      id: '3',
      name: 'Talat Hussain',
      status: 'online',
      avatar: 'TH',
      isOnline: true,
    ),
    Contact(
      id: '4',
      name: 'Sir Taimoor Riaz',
      status: 'Active 14 min ago',
      avatar: 'ST',
      isOnAegis: true,
    ),
    Contact(
      id: '5',
      name: 'Sir Majid Zaman',
      status: 'online',
      avatar: 'SM',
      isOnline: true,
    ),
    Contact(
      id: '6',
      name: 'Michael Brown',
      status: 'Not on Aegis',
      avatar: 'MB',
      isOnAegis: false,
    ),
  ];
}