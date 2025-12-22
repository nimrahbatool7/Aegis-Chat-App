import 'package:flutter/material.dart';

import 'chat_list_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aegis Chat Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _Header(),
              SizedBox(height: 40),
              _PhoneInput(),
              SizedBox(height: 20),
              _ContinueButton(),
              SizedBox(height: 24),
              _TestLinks(),
            ],
          ),
        ),
      ),
    );
  }
}


/// HEADER


class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      'Welcome to Aegis Chat',
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}


/// PHONE INPUT


class _PhoneInput extends StatelessWidget {
  const _PhoneInput();

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixText: '+92 ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}


/// CONTINUE BUTTON


class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ChatListScreen(),
            ),
          );
        },
        child: const Text('Continue'),
      ),
    );
  }
}


/// TEST / DEBUG LINKS


class _TestLinks extends StatelessWidget {
  const _TestLinks();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/session-expired');
          },
          child: const Text('Test Session Expired'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/test-screens');
          },
          child: const Text('Test Screens'),
        ),
      ],
    );
  }
}
