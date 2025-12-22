import 'package:flutter/material.dart';
import 'incoming_threat_warning.dart';
import '../models/threat_model.dart';

class TestThreatScreen extends StatelessWidget {
  const TestThreatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Threat Screens')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomingThreatWarning(
                      threatType: ThreatType.malwareFile,
                      fileName: 'Project_Send_new_request_final.pdf',
                      fileSize: '140 KB',
                      threatDescription: 'This file appears to contain harmful content. Opening it may compromise your device.',
                      senderName: 'talat Hassain',
                    ),
                  ),
                );
              },
              child: const Text('Test Malware File Warning'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomingThreatWarning(
                      threatType: ThreatType.harmfulLink,
                      fileName: 'Suspicious Link',
                      fileSize: 'N/A',
                      threatDescription: 'This link leads to a potentially dangerous website.',
                      linkUrl: 'https://malicious-website.com',
                      senderName: 'M. huzaifa',
                    ),
                  ),
                );
              },
              child: const Text('Test Harmful Link Warning'),
            ),
          ],
        ),
      ),
    );
  }
}